<%@ page contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.List,java.util.ArrayList,java.util.Map,java.util.HashMap,java.util.Properties" %>
<html>
<head><title>∫Û∂À</title>
</head>
<body>

<%
	int cp = Integer.parseInt(request.getParameter("cp")==null?"1":request.getParameter("cp")) ;
	int ps = Integer.parseInt(request.getParameter("ps")==null?"3":request.getParameter("ps")) ;
	String ename = request.getParameter("ename")==null?"":request.getParameter("ename");
	String job = request.getParameter("job")==null?"":request.getParameter("job");


	Properties pro = new Properties();  
	String realpath = request.getRealPath("/");  
	FileInputStream in = new FileInputStream(realpath+"/resources/application.properties");  
	pro.load(in);  
	
	String dburl = pro.getProperty("dburl"); 
	String username = pro.getProperty("username"); 
	String password = pro.getProperty("password"); 
	String driver = pro.getProperty("driver"); 

	Connection conn = null ;
	PreparedStatement pstmt = null ;
	ResultSet rs = null ;
	
	Class.forName(driver) ;
	conn = DriverManager.getConnection(dburl,username,password) ;
	
	Integer count= null;
	String countSql = "SELECT COUNT(empno) FROM emp where 1=1 " ;
	if(!ename.equals("")){
		ename =ename.trim();
		countSql += " and upper(ename) like upper('%"+ename+"%')";
	}
	if(!job.equals("")){
		job =job.trim();
		countSql += " and upper(job) like upper('%"+job+"%')";
	}
	pstmt = conn.prepareStatement(countSql) ;
	rs = pstmt.executeQuery() ;
	if(rs.next()){	
		count = rs.getInt(1) ;
	}
	System.out.println(countSql);

	List<HashMap<String,String>> dataList = new ArrayList<HashMap<String,String>>();
	
	String dataSql = null;
	Integer param1 = null;
	Integer param2 = null;
	if(dburl.contains("mysql")){
		//mysql∑÷“≥sql
		dataSql = "select empno,ename,job,hiredate,sal,comm from emp where 1=1";
		if(!ename.equals("")){
			ename =ename.trim();
			dataSql += " and upper(ename) like upper('%"+ename+"%')";
		}
		if(!job.equals("")){
			job =job.trim();
			dataSql += " and upper(job) like upper('%"+job+"%')";
		}
		dataSql += " limit ?,?";
		param1 = (cp-1) * ps;
		param2 = ps;
	}
	if(dburl.contains("oracle")){
		//oracle∑÷“≥sql 
		dataSql = 	"SELECT * FROM (" + 
		" SELECT empno,ename,job,hiredate,sal,comm,ROWNUM rn" +
		" FROM emp WHERE ROWNUM<=?";
		if(!ename.equals("")){
			ename =ename.trim();
			dataSql += " and upper(ename) like upper('%"+ename+"%')";
		}
		if(!job.equals("")){
			job =job.trim();
			dataSql += " and upper(job) like upper('%"+job+"%')";
		}
		dataSql += 
		" ORDER BY empno ) temp" + 
		" WHERE temp.rn>?" ;
		param1 = cp * ps;
		param2 = (cp-1) * ps;
	}
	pstmt = conn.prepareStatement(dataSql) ;
	pstmt.setInt(1,param1) ;
	pstmt.setInt(2,param2) ;
	rs = pstmt.executeQuery() ;
	
	dataSql= dataSql.replace("%","%%").replace("?","%s");
	dataSql= String.format(dataSql,param1,param2);
	System.out.println(dataSql);

	while(rs.next()){
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("empno",String.valueOf(rs.getInt(1)));
		map.put("ename",String.valueOf(rs.getString(2)));
		map.put("job",String.valueOf(rs.getString(3)));
		map.put("hiredate",String.valueOf(rs.getDate(4)));
		map.put("sal",String.valueOf(rs.getDouble(5)));
		map.put("comm",String.valueOf(rs.getDouble(6)));
		dataList.add(map);
	}
	conn.close() ;	
	
	request.setAttribute("dataList",dataList);
	String url = "search_fenye_list.jsp?cp="+cp+"&ps="+ps+"&count="+count+"&ename="+ename+"&job="+job;
	request.getRequestDispatcher(url).forward(request,response);
%>
</body>
</html>