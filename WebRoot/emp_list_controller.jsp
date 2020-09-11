<%@ page contentType="text/html" pageEncoding="GBK"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List,java.util.ArrayList,java.util.Map,java.util.HashMap" %>
<html>
<head><title>�����</title>
</head>
<body>
<%!
public static final String DBDRIVER = "com.mysql.jdbc.Driver" ;
public static final String DBURL = "jdbc:mysql://localhost/fenye" ;
public static final String DBUSER = "root" ;
public static final String DBPASSWORD = "root" ;
%>
<%--!
public static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver" ;
public static final String DBURL = "jdbc:oracle:thin:@localhost:1521:orcl" ;
public static final String DBUSER = "scott" ;
public static final String DBPASSWORD = "orcl" ;
--%>
<%
//��̨
//����ǰ̨��cp��ps��kw
//���ظ�ǰ̨��cp��ps��kw��count��dataList
	int cp = Integer.parseInt(request.getParameter("cp")==null?"1":request.getParameter("cp")) ;
	int ps = Integer.parseInt(request.getParameter("ps")==null?"5":request.getParameter("ps")) ;
	String kw = request.getParameter("kw")==null?"":request.getParameter("kw");
	
	Connection conn = null ;
	PreparedStatement pstmt = null ;
	ResultSet rs = null ;
	
	Class.forName(DBDRIVER) ;
	conn = DriverManager.getConnection(DBURL,DBUSER,DBPASSWORD) ;
	
	int count=0;
	String countSql = "SELECT COUNT(empno) FROM emp where 1=1 " ;
	if(kw!=null && !kw.equals("")){
		kw =kw.trim();
		countSql += " and upper(ename) like  upper('%"+kw+"%')";
	}
	System.out.println(countSql);
	pstmt = conn.prepareStatement(countSql) ;
	rs = pstmt.executeQuery() ;
	if(rs.next()){	
		count = rs.getInt(1) ;
	}
%>
<%
	//mysql�ķ�ҳ��Ҫ�����кź�Ҫ��ѯ��������һ����ʼ�к�,��0��ʼ��һ����������ҳ���С
	List<HashMap<String,String>> dataList = new ArrayList<HashMap<String,String>>();
	String dataSql = "select empno,ename,job,hiredate,sal,comm from emp where 1=1 ";
	if(kw!=null && !kw.equals("")){
		kw =kw.trim();
		dataSql += " and upper(ename) like upper('%"+kw+"%')";
	}
	dataSql += " limit ?,?";
	pstmt = conn.prepareStatement(dataSql) ;
	pstmt.setInt(1,(cp-1) * ps) ;
	pstmt.setInt(2, ps) ;
	rs = pstmt.executeQuery() ;
%>
<%--
	//oracle�ķ�ҳ����Ҫ��2���кţ�һ����ʼ�кţ���1��ʼ��һ�������к�
	List<HashMap<String,String>> dataList = new ArrayList<HashMap<String,String>>();
	String dataSql = 	"SELECT * FROM (	" + 
	" SELECT empno,ename,job,hiredate,sal,comm,ROWNUM rn " +
	" FROM emp WHERE ROWNUM<=? ";
	if(kw!=null && !kw.equals("")){
		kw =kw.trim();
		dataSql += " and upper(ename) like upper('%"+kw+"%')";
	}
	dataSql += 
	" ORDER BY empno) temp " + 
	" WHERE temp.rn>? " ;
	pstmt = conn.prepareStatement(dataSql) ;
	pstmt.setInt(1,cp * ps) ;
	pstmt.setInt(2,(cp-1) * ps) ;
	rs = pstmt.executeQuery() ;	
--%>	
<%	
	while(rs.next()){
		HashMap<String,String> map = new HashMap<String,String>();
		int empno = rs.getInt(1) ;
		String ename = rs.getString(2) ;
		String job = rs.getString(3) ;
		Date hiredate = rs.getDate(4) ;
		double sal = rs.getDouble(5) ;
		double comm = rs.getDouble(6) ;
		map.put("empno",String.valueOf(empno));
		map.put("ename",String.valueOf(ename));
		map.put("job",String.valueOf(job));
		map.put("hiredate",String.valueOf(hiredate));
		map.put("sal",String.valueOf(sal));
		map.put("comm",String.valueOf(comm));
		dataList.add(map);
	}
	conn.close() ;	
	
	request.setAttribute("dataList",dataList);
	String url = "emp_list.jsp?cp="+cp+"&ps="+ps+"&kw="+kw+"&count="+count;
	request.getRequestDispatcher(url).forward(request,response);
%>
</body>
</html>