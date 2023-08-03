<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div align="center">
	<h3>계약서</h3>
		<table>
			<tr>
				<td>계약명 :</td>
				<td>${map.contract_name }</td>
			</tr>
			<tr>
				<td>계약 기간 :</td>
				<td>${map.contract_start} ~ ${map.contract_end }</td>
			</tr>
			<tr>
				<td>프로젝트명 :</td>
				<td>${map.project_name }</td>
			</tr>
			<tr>
				<td>프로젝트 기간 :</td>
				<td>${map.project_start} ~ ${map.project_end }</td>
			</tr>
			<tr>
				<td>거래처 담당자 :</td>
				<td>${map.client_manager }</td>
			</tr>
			<tr>
				<td>전화번호 :</td>
				<td>${map.client_contact }</td>
			</tr>
			<tr>
				<td>계약 종류 :</td>
				<td>${map.contractkind_name }</td>
			</tr>
			<tr>
				<td>내용 :</td>
				<td>${map.contract_content }</td>
			</tr>
			<tr>
				<td><button onclick="client(${map.client_no})">거래처 정보</button></td>
			</tr>
		</table><br>
		
		<table id="clientInfo">
			
		</table>
		<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath }/a/a3/a32/updateFormC?contract_no=${map.contract_no }'">
		<input type="button" value="삭제" onclick="location.href='${pageContext.request.contextPath }/a/a3/a32/delete?contract_no=${map.contract_no }&comcode_code=${comcode_code }'">
</div>

<script type="text/javascript">
	function clientcheck(cno){
		var url = "${pageContext.request.contextPath}/a/a3/a32/clientInfo";
		var param = "client_no=" + encodeURIComponent(cno);

		sendRequest(url, param, client, "POST");
	}
	function client(){
		if(xhr.readyState==4 && xhr.status==200) {
			var data = xhr.response;
			if(data != null){
				var ct = document.getElementById("clientInfo");
				var newTd = document.createElement("td");
				var newTr = document.createElement("tr");
				ct.innerHTML = '';
				ct.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerText = "국가";
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = "거래처명";
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = "사업형태";
				newTr.appendChild(newTd);
				
				newTr = document.createElement("tr");
				ct.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerText = data.country_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = data.client_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = data.client_businesstype;
				newTr.appendChild(newTd);
				
				newTr = document.createElement("tr");
				ct.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerText = "사업자등록번호";
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = "업태";
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = "종목";
				newTr.appendChild(newTd);
				
				newTr = document.createElement("tr");
				ct.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerText = data.client_registeredno;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = data.businesstype_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = data.businesstype_subctgr;
				newTr.appendChild(newTd);
				
				newTr = document.createElement("tr");
				ct.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerText = "대표자";
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = "전화번호";
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = "E-mail";
				newTr.appendChild(newTd);
				
				newTr = document.createElement("tr");
				ct.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerText = data.client_representative;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = data.client_directno;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerText = data.client_email;
				newTr.appendChild(newTd);
				
				newTr = document.createElement("tr");
				ct.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerText = "fax";
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.setAttribute("colspan", "2");
				newTd.innerText = "주소";
				newTr.appendChild(newTd);
				
				newTr = document.createElement("tr");
				ct.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerText = data.client_fax;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.setAttribute("colspan", "2");
				newTd.innerText = data.client_postal + " " + data.client_addr1 + " " + data.client_addr2;
				newTr.appendChild(newTd);
			}else {
				var ct = document.getElementById("clientInfo");
				ct.innerHTML = '';
				alert("등록된 거래처가 없습니다.");
			}
		}
	}
</script>
</body>
</html>