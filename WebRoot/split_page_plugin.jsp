<%@ page contentType="text/html" pageEncoding="GBK"%>
<style>
a{color:#666; text-decoration:none;}
</style>
<script language="javascript">
	function goPage(num){
		var maxPageNum = document.getElementById("maxPageNum").innerHTML;		
		if(num>maxPageNum || num<1){
			return false;
		}
		var cp = document.getElementById("cp").value;
		if(num==cp){
			return false;
		}
		//����Ǹ�select���棬optionû���Ǹ�ֵ���͸�ֵ�����Ǹ����ǾͲ��ᴫֵ��Ҳ����name=cp���input���൱�ڱ�disabled��
		document.getElementById("cp").value = num ; 
		query();
	}
	function goPageOne(){
		document.getElementById("cp").value = 1 ; 
		query();
	}
</script>
<%
	int cp = Integer.parseInt(request.getParameter("cp")) ;			// ��ǰ���ڵ�ҳ
	int ps = Integer.parseInt(request.getParameter("ps")) ; ;		// ҳ���С
	int count = Integer.parseInt(request.getParameter("count")) ;  	// һ���ж���������
	
	int maxPageNum = (count + ps -1) / ps ;// ����ҳ��
%>
<div style="width:60%;" align="right">
	���ҵ���������������<%=count %>��&nbsp;
	
	��<span id="maxPageNum"><%=maxPageNum %></span>ҳ&nbsp;
	
	<a href="javascript:void(0);" onclick="goPage(1)" >
		<img src="images/firstPage.gif" />
	</a>&nbsp;
	<a href="javascript:void(0);" onclick="goPage(<%=cp-1%>)" >
		<img src="images/previousPage.gif" />
	</a>&nbsp;
	<a href="javascript:void(0);" onclick="goPage(<%=cp+1%>)" >
		<img src="images/nextPage.gif" />
	</a>&nbsp;
	<a href="javascript:void(0);" onclick="goPage(<%=maxPageNum%>)" 	>
		<img src="images/lastPage.gif" />
	</a>&nbsp;
	
	��ת����
		<select id="cp" name="cp" onchange="javascript:this.form.submit();">
				<option value="1" <%=1==cp?"selected":""%>>1</option>
		<%
			for(int i=2;i<=maxPageNum;i++){
		%>
				<option value="<%=i%>" <%=i==cp?"selected":""%>><%=i%></option>
		<%
			}
		%>
		</select>ҳ&nbsp;
		
	ÿҳ��ʾ
		<select name="ps" onchange="goPageOne()">
		<%
			int psArr[] = {2,3,5,10,20,50} ;   
			for(int i=0;i<psArr.length;i++){
		%>
			<option value="<%=psArr[i]%>" <%=psArr[i]==ps?"selected":""%>><%=psArr[i]%></option>
		<%
			}
		%>
		</select>
	��&nbsp;
	 
</div>