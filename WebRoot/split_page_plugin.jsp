<%@ page contentType="text/html" pageEncoding="GBK"%>
<style>
a{color:#666; text-decoration:none;}
</style>
<script language="javascript">
	function goPage(num){
		//如果那个select里面，option没有那个值，就赋值不了那个，那就不会传值，也就是name=cp这个input，相当于被disabled了
		document.getElementById("cp").value = num ; 
		query();
	}
</script>
<%
	int cp = Integer.parseInt(request.getParameter("cp")) ;			// 当前所在的页
	int ps = Integer.parseInt(request.getParameter("ps")) ; ;		// 页面大小
	int count = Integer.parseInt(request.getParameter("count")) ;  	// 一共有多少条数据
	
	int maxPageNum = (count + ps -1) / ps ;// 最大的页号
%>
<div style="width:60%;" align="right">
	共找到符合条件的数据<%=count %>条
	
	<a href="javascript:void();" onclick="goPage(1)" >
		<img src="images/firstPage.gif" />
	</a>&nbsp;
	<a href="javascript:void();" onclick="goPage(<%=cp-1%>)" >
		<img src="images/previousPage.gif" />
	</a>&nbsp;
	<a href="javascript:void();" onclick="goPage(<%=cp+1%>)" >
		<img src="images/nextPage.gif" />
	</a>&nbsp;
	<a href="javascript:void();" onclick="goPage(<%=maxPageNum%>)" 	>
		<img src="images/lastPage.gif" />
	</a>&nbsp;
	
	跳转到第
		<select id="cp" name="cp" onchange="javascript:this.form.submit();">
				<option value="1" <%=1==cp?"selected":""%>>1</option>
		<%
			for(int i=2;i<=maxPageNum;i++){
		%>
				<option value="<%=i%>" <%=i==cp?"selected":""%>><%=i%></option>
		<%
			}
		%>
		</select>页&nbsp;
		
	每页显示
		<select name="ps" onchange="goPage(1)">
		<%
			int psArr[] = {5,10,20,50} ;   
			for(int i=0;i<psArr.length;i++){
		%>
			<option value="<%=psArr[i]%>" <%=psArr[i]==ps?"selected":""%>><%=psArr[i]%></option>
		<%
			}
		%>
		</select>
	条&nbsp;
	 
</div>