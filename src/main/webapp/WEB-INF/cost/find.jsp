<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="styles/global_color.css" />
        <script src="js/jquery-1.11.1.js"></script>
        <script language="javascript" type="text/javascript">
      		//排序信息
			var orderName;
			var orderType;
			//排序按钮的点击事件
			function sort(btnObj) {
					var val = btnObj.value;
				if (btnObj.className == "sort_desc") {
					btnObj.className = "sort_asc";
					orderType = "asc";
				} else {
					btnObj.className = "sort_desc";
					orderType = "desc";
				}
				if(val=='月租'){
					orderName = 'name';
				} else if(val=='基费'){
					orderName = 'base_cost';
				} else if(val=='时长'){
					orderName = 'base_duration';
				}
				location.href = "findCost.do?orderName="+orderName+"&orderType="+orderType;
			}

			//启用
			function startFee(btn) {
				var r = window.confirm("确定要启用此资费吗？资费启用后将不能修改和删除。");
				if (r) {
					document.getElementById("operate_result_info").style.display = "block";
					var id = $(btn).parent().siblings().eq(0).html();
					window.location.href = "openCost.do?costId=" + id;
				}
			}
			//删除
			function deleteFee(btn) {
				var r = window.confirm("确定要删除此资费吗？");
				if (r) {
					var id = $(btn).parent().siblings().eq(0).html();
					window.location.href = "deleteCost.do?costId=" + id;
				}
			}
			
			$(function(){
				var orderName = '${orderName}';
				var orderType = '${orderType}';
				if(orderType == 'asc')
					return;
				if(orderName=='name'){
					$("[value='月租']").removeClass('sort_asc').addClass('sort_desc');
				} else if(orderName=='base_duration'){
					$("[value='时长']").removeClass('sort_asc').addClass('sort_desc');
				} else if(orderName=='base_cost'){
					$("[value='基费']").removeClass('sort_asc').addClass('sort_desc');
				}
			});
		</script>        
    </head>
    <body>
        <!--Logo区域开始-->
        <div id="header">
            <img src="images/logo.png" alt="logo" class="left"/>
            <a href="#">[退出]</a>            
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <div id="navi">                        
            <ul id="menu">
                <li><a href="toIndex.do" class="index_off"></a></li>
                <li><a href="../role/role_list.html" class="role_off"></a></li>
                <li><a href="../admin/admin_list.html" class="admin_off"></a></li>
                <li><a href="findCost.do" class="fee_off"></a></li>
                <li><a href="../account/account_list.html" class="account_off"></a></li>
                <li><a href="../service/service_list.html" class="service_off"></a></li>
                <li><a href="../bill/bill_list.html" class="bill_off"></a></li>
                <li><a href="../report/report_list.html" class="report_off"></a></li>
                <li><a href="../user/user_info.html" class="information_off"></a></li>
                <li><a href="../user/user_modi_pwd.html" class="password_off"></a></li>
            </ul>            
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form action="" method="">
                <!--排序-->
                <div class="search_add">
                    <div>
    					<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="时长" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="基费" class="sort_asc" onclick="sort(this);" />
                    </div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAddCost.do';" />
                </div> 
                <!--启用操作的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="images/close.png" onclick="this.parentNode.style.display='none';" />
                   操作成功！
                </div>    
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                        	<!-- th是特殊的td,里面的内容自动加粗并居中 -->
                            <th>资费ID</th>
                            <th class="width100">资费名称</th>
                            <th>基本时长</th>
                            <th>基本费用</th>
                            <th>单位费用</th>
                            <th>创建时间</th>
                            <th>开通时间</th>
                            <th class="width50">状态</th>
                            <th class="width200"></th>
                        </tr>
                        <tbody id="datebody">
                        <c:forEach items="${costs}" var="c">                    
                        <tr>
                            <td>${c.costId}</td>
                            <td><a href="detailCost.do?costId=${c.costId}">${c.name}</a></td>
                            <td>${c.baseDuration} 小时</td>
                            <td>${c.baseCost} 元</td>
                            <td>${c.unitCost} 元/分钟</td>
                            <td><fmt:formatDate value="${c.creatime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${c.startime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
                            <td>
								<c:if test="${c.status==1}">暂停</c:if>
								<c:if test="${c.status==0}">开通</c:if>
							</td>
                            <td>                                
							<c:if test="${c.status!=0}">
                                <input type="button" value="启用" class="btn_start" onclick="startFee(this);" />
                                <input type="button" value="修改" class="btn_modify" onclick="location.href='toModifyCost.do?costId=${c.costId}';" />
                                <input type="button" value="删除" class="btn_delete" onclick="deleteFee(this);" />
                            </c:if>
                            </td>
                        </tr>
                       </c:forEach>
                       </tbody>  
                    </table>
                    <!-- <p>业务说明：<br />
                    1、创建资费时，状态为暂停，记载创建时间；<br />
                    2、暂停状态下，可修改，可删除；<br />
                    3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；<br />
                    4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
                    </p> -->
                </div>
                <!--分页-->
                <div id="pages">
        	        <a href="findCost.do?pageNum=1">首页</a>
        	        <%
        	        	int curr = (Integer)request.getAttribute("costPage");
        	        	int totalCost = (Integer)request.getAttribute("totalCost");
        	        	// 计算最大页码数
        	    		int max = (int) Math.ceil(totalCost / 10.0);
        	    		// 页面中显示的开始页和结束页,最多出现5个页码
        	    		int start=0, end=0;
        	    		if(curr==1 || curr == 2){
        	    			start = 1;
        	    			end = 5;
        	    		} else if (curr == max || curr == max -1) {
        	    			start = max - 4;
        	    			end = max;
        	    		} else {
        	    			start = curr - 2;
        	    			end = curr + 2;
        	    		}
        	    	%>
        	    	<a href="findCost.do?pageNum=<%=curr-1%>&orderName=${orderName}&orderType=${orderType}">上一页</a>
        	    	<%
        	        	for(int i = start; i <=end; i++){
        	        		if(i>=1&&i<=max){
        	        			if(i == curr){
        	        %>
        	        			<a href="findCost.do?pageNum=<%=i%>&orderName=${orderName}&orderType=${orderType}" class="current_page"><%=i%></a>
        	        <%
        	        			}else{
        	        %>
								<a href="findCost.do?pageNum=<%=i%>&orderName=${orderName}&orderType=${orderType}"><%=i%></a>
					<%	
        	        			}
        	        		}
        	        	}
        	        %>
                    <a href="findCost.do?pageNum=<%=curr+1%>&orderName=${orderName}&orderType=${orderType}">下一页</a>
                    <a href="findCost.do?pageNum=<%=max%>&orderName=${orderName}&orderType=${orderType}">尾页</a>
                </div>
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</p>
            <p>版权所有(C)加拿大达内IT培训集团公司 </p>
        </div>
    </body>
</html>
