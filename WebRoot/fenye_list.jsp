<%@ page contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List,java.util.ArrayList,java.util.Map,java.util.HashMap" %>
<html>
<head><title>前端</title>
<link rel="stylesheet" href="css/main.css" />
<script language="javascript">
	function query(){
		document.spform.submit() ;	 
	}
</script>
</head>
<body>
<%
int cp = Integer.parseInt(request.getParameter("cp")) ;
int ps = Integer.parseInt(request.getParameter("ps")) ;
int count = Integer.parseInt(request.getParameter("count")) ;
List<HashMap<String,String>> dataList = (List<HashMap<String,String>>)request.getAttribute("dataList");
%>
   <center> 
	<h1>雇员列表</h1>
	<form name="spform" action="fenye_controller.jsp" method="post">
	<table class="tablecontent">
		<thead>
			<tr>
				<td>编号</td>
				<td>姓名</td>
				<td>职位</td>
				<td>雇佣日期</td>
				<td>工资</td>
				<td>奖金</td>
			</tr>
		</thead>
	<%	List<HashMap<String,String>> list = dataList;   %>
	<%	for(int i=0; i<list.size();i++){				%>
		<tr <%if(i%2==0){%>class="even"<%}%>>
			<td><%=list.get(i).get("empno")%></td>
			<td><%=list.get(i).get("ename")%></td>
			<td><%=list.get(i).get("job")%></td>
			<td><%=list.get(i).get("hiredate")%></td>
			<td><%=list.get(i).get("sal")%></td>
			<td><%=list.get(i).get("comm")%></td>
		</tr>
	<%	}	%>
	<%  if(list.isEmpty()){ %>
		<tr>
			<td align="center"  colspan="6">没有任何查询结果！</td>
		</tr>		
	<%  }	%>
	</table><br>
	<jsp:include page="components/split_page_plugin.jsp">
		<jsp:param name="cp" value="<%=cp%>"/>
		<jsp:param name="ps" value="<%=ps%>"/>
		<jsp:param name="count" value="<%=count%>"/>
	</jsp:include>
	</form>
</center>
 </body>
</html>
