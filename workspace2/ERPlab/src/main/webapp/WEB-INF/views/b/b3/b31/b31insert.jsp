<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
    /* Remove the arrow buttons from input[type="number"] */
    input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    input[type="number"] {
        -moz-appearance: textfield; /* Firefox */
    }
</style>

<div class="statement-container">

    <div class="b31-head">

    <h1>일반전표 입력</h1>
    
    </div>
    
    <div class="b31-body">
        
    <table class="b31-clausesInsert" id="b31-itemTableInsert">
    
        <tr>
            <th>checkbox</th>
            <th>년</th>
            <th>월</th>
            <th>일</th>
            <th>고유코드</th>
            <th>구분</th>
            <th>차변 계정과목</th>
            <th>차변 금액</th>
            <th>대변 계정과목</th>
            <th>대변 금액</th>
            <th>적요</th>
            <th>거래처</th>
            <th>삭제</th>
        </tr>
        
        <tr>
            <td></td>
            <td><input type="text" name="b31-year" /></td>
            <td><input type="text" name="b31-month" /></td>
            <td><input type="text" name="b31-day" /></td>
            <td><input type="text" name="b31-code" /></td>
            <td><input type="text" name="b31-category" /></td>
            <td><input type="text" name="b31-debit-account" /></td>
            <td><input type="number" name="b31-debit-amount" /></td>
            <td><input type="text" name="b31-credit-account" /></td>
            <td><input type="number" name="b31-credit-amount" /></td>
            <td><input type="text" name="b31-summary" /></td>
            <td><input type="text" name="b31-partner" /></td>
            <td><input type="button" id=b31-clearRow /></td>
        </tr>

        <tr>
            <th colspan="4">선택 전표 소계</th>
            <td colspan="2"></td>
            <td></td>
            <td id="debitAmountTotal">debitAmount</td>
            <td></td>
            <td id="creditAmountTotal">creditAmount</td>
            <td colspan="2">기타</td>
        </tr>
    
    </table>
    
    <input type="button" id="b31-addRow" value="행 추가" />
    <input type="button" id="b31-deleteRow" value="행 삭제" />
    
    </div>

</div>

<script type="text/javascript">

	// <전표 항목>
	window.addEventListener('load', function () {
	    for (let i = 0; i < 3; i++) {
	        addNewRow();
	    }
	});

	document.getElementById('b31-addRow').addEventListener('click', addNewRow);
    document.getElementById('b31-deleteRow').addEventListener('click', deleteRow);

	function addNewRow() {
	    const table = document.getElementById('b31-itemTableInsert');
	    const rowCount = table.rows.length;
	
	    if (rowCount - 2 < 10) {
	        const newRow = table.insertRow(rowCount - 1);
	        newRow.innerHTML = `
	            <td></td>
	            <td><input type="text" class="b31-year" /></td>
	            <td><input type="text" class="b31-month" /></td>
	            <td><input type="text" class="b31-day" /></td>
	            <td><input type="text" class="b31-code" /></td>
	            <td><input type="text" class="b31-category" /></td>
	            <td><input type="text" class="b31-debit-account" /></td>
	            <td><input type="text" class="b31-debit-amount" /></td>
	            <td><input type="text" class="b31-credit-account" /></td>
	            <td><input type="text" class="b31-credit-amount" /></td>
	            <td><input type="text" class="b31-summary" /></td>
	            <td><input type="text" class="b31-partner" /></td>
	        `;
	    } else {
	        alert("최대 10개의 행까지 추가할 수 있습니다.");
	    }
	}
	
    function deleteRow() {
        const table = document.getElementById('b31-itemTableInsert');
        const rowCount = table.rows.length;
        
        if (rowCount -2 <= 4) {
            alert("행은 4개 이하가 될 수 없습니다.");
            return;
        }

        table.deleteRow(rowCount - 2);
    }

    
</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    