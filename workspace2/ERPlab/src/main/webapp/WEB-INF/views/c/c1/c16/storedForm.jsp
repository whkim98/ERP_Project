<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<%@include file="/WEB-INF/views/layout/header.jsp" %>

<form action="${pageContext.request.contextPath }/internationsales/income/stored">
<input type="hidden" name="importorder_no" value="${importorder_no }">
<input type="hidden" name="comcode_code" value=${comcode_code }>
      <div align="center">
         <h1 style="font-size: 20pt;">입고처리</h1>
      </div>
<div>
CINO<input type="text" name="import_cino">
BLNO<input type="text" name="import_blno">


                     <label>차변 </label>
                     <select name="bs3_no">
						  <c:forEach var="vo" items="${listd}">
						    <option value="${vo.bs3_no}">
						      ${vo.bs3_ctgr}
						    </option>
						  </c:forEach>
						</select>

                  </div>   
                  
                  <div>
                     <label>대변</label> 
                     <select name="dbs3_no">
						  <c:forEach var="vo" items="${listc}">
						    <option value="${vo.bs3_no}">
						      ${vo.bs3_ctgr}
						    </option>
						  </c:forEach>
						</select>
                  </div>
                  
                  <div>
                  		
                     <input type="submit" value="입력">
                     <input type="reset" value="reset">
                  </div>
                  
                  </form>