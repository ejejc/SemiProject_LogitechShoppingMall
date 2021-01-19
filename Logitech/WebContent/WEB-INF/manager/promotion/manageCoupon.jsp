<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../managerHeader.jsp" />

<style>
#couponState {
	float: left;
	width: 95%;
	margin: 20px;
}

.divCell, .divContent {
	text-align: center;
}

#searchOption1, #searchOption2 {
	height: 30px;
	margin-right: 10px;
}

#searchKey1, #searchKey2 {
	width: 150px;
	height: 30px;
	margin-right: 20px;
}

#btnSearch {
	margin-right: 20px;
}

#sizePerPage {
	height: 30px;
}

#tblCoupon {
	width: 100%;
}

#tblCoupon > thead > tr {
	background-color: #bfbfbf;
}

#tblCoupon, #tblCoupon tr, #tblCoupon th, #tblCoupon td {
	border: solid 1px #ccc;
	text-align: center;
}

#tblCoupon th, #tblCoupon td {
	height: 70px;
}

#tHeadRow > th:hover {
	background-color: #e6ffe6;
	cursor: pointer;
}

tr.ecouponInfo:hover {
	background-color: #e6e6e6;
	cursor: pointer;
}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$("span.hiddenVal").hide();
		$("span.hiddenSort").hide();
	
		if("${sortFlag}" != null) {
			$(".hiddenSort").html("${sortFlag}");
		}
		
		if("${searchKey1}" != "") {  // 처음에는 검색어가 있지 않기 때문에 if 문으로 경우를 나눈다.
			$("select#searchOption1").val("${searchOption1}");
			$("input#searchKey1").val("${searchKey1}");
		}// end of if("${searchKey1}" != ""){}---------------------
		
		if("${searchKey2}" != "") {  // 처음에는 검색어가 있지 않기 때문에 if 문으로 경우를 나눈다.
			$("select#searchOption2").val("${searchOption2}");
			$("input#searchKey2").val("${searchKey2}");
		}// end of if("${searchKey1}" != ""){}---------------------
		
		var searchKey1 = $("input#searchKey1").val().trim();
		
		if(searchKey1 == "") {
			$("input#searchKey2").prop("disabled", true);
		}// end of if(searchKey1 == ""){}------------------------
		
		$("input#searchKey1").blur(function(){
			if($(this).val().trim() != "") {
				$("input#searchKey2").prop("disabled", false);
			} else {
				$("input#searchKey2").prop("disabled", true);
			}// end of if($(this).val().trim() != ""){}------------------------
		})// end of $("input#searchKey1").blur(function(){})------------------------
		
		$("input#searchKey1").keyup(function(event){
			if(event.keyCode == 13) {  // 검색어에서 엔터를 치면 검색되도록 한다.
				goSearch();
			}// end of if(event.keyCode == 13){}-----------------
		});// end of $("input#searchKey1").keyup(function(){})--------------------
		
		$("input#searchKey2").keyup(function(event){
			if(event.keyCode == 13) {  // 검색어에서 엔터를 치면 검색되도록 한다.
				goSearch();
			}// end of if(event.keyCode == 13){}-----------------
		});// end of $("input#searchKey2").keyup(function(){})--------------------
				
		$("select#sizePerPage").bind("change", function(){
			goSearch();
		});// end of $("select#sizePerPage").bind("change", function(){})-------------------
		
		if("${sizePerPage}" != "") {
			$("select#sizePerPage").val("${sizePerPage}");
		}// end of if("${sizePerPage}" != ""){}------------------------
		
		$("tr#tHeadRow > th").click(function(){
			var selectedHead = $(this).children(".hiddenVal").text();
			var sortFlag = $(this).children(".hiddenSort").text();
			
			if(sortFlag == "asc") {
				sortFlag = "desc";
			} else {
				sortFlag = "asc";
			}// end of if(sortFlag == asc){}--------------------
			
			location.href = '<%= ctxPath%>/manager/promotion/couponList.sg?currentPageNo=1&sizePerPage='+"${sizePerPage}"+'&searchOption1='+"${searchOption1}"+'&searchKey1='+"${searchKey1}"+'&searchOption2='+"${searchOption2}"+'&searchKey2='+"${searchKey2}"+'&selectedHead='+selectedHead+'&sortFlag='+sortFlag;
		});// end of $("tr#tHeadRow > th").click(function(){})----------------------
		
		$("tr.ecouponInfo").click(function(){
			var eachcouponcode = $(this).children(".eachcouponcode").text();
			
			location.href = "<%= ctxPath%>/manager/promotion/couponOneDetail.sg?eachcouponcode="+eachcouponcode+"&goBackURL=${goBackURL}";
		});// end of $("tr.ecouponInfo").click(function(){})----------------------
	});// end of $(document).ready(function(){})--------------------------
	
	function goSearch() {
		var frm = document.frmList;
		frm.action = "<%= ctxPath%>/manager/promotion/couponList.sg";
		frm.method = "get";
		frm.submit();
	}// end of function goSearch(){}------------------------
</script>

<form name="frmList">
	<div id="couponState">
		<div class="row">
			<div class="col-sm-12">
				<div class="well" style="background-color: white;">
					<h4>쿠폰 현황</h4> 
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well divCell" style="background-color: white;">
					<select id="searchOption1" name="searchOption1">
						<option>옵션1</option>
						<option value="fk_couponcode">쿠폰코드</option>
						<option value="couponname">쿠폰명</option>
						<option value="fk_membershipname">적용회원등급</option>
						<option value="fk_memberno">발급회원번호</option>
						<option value="status">상태</option>
						<option value="endday">만료일자</option>
					</select>
					
					<input type="text" id="searchKey1" name="searchKey1" placeholder="1차 검색 조건" />
					
					<select id="searchOption2" name="searchOption2">
						<option>옵션2</option>
						<option value="fk_couponcode">쿠폰코드</option>
						<option value="couponname">쿠폰명</option>
						<option value="fk_membershipname">적용회원등급</option>
						<option value="fk_memberno">발급회원번호</option>
						<option value="status">상태</option>
						<option value="endday">만료일자</option>
					</select>
					
					<input type="text" id="searchKey2" name="searchKey2" placeholder="2차 검색 조건" />
					
					<button type="button" id="btnSearch" onclick="goSearch();">검색</button>
					
					<select id="sizePerPage" name="sizePerPage">
						<option value="5">5개씩 보기</option>
						<option value="10" selected="selected">10개씩 보기</option>
						<option value="20">20개씩 보기</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well divContent" style="background-color: white;">
					<table id="tblCoupon">
						<thead>
							<tr id="tHeadRow" align="center">
								<th>쿠폰코드<span class="hiddenVal">fk_couponcode</span><span class="hiddenSort">desc</span></th>
								<th>개별쿠폰번호<span class="hiddenVal">eachcouponcode</span><span class="hiddenSort">desc</span></th>
								<th>쿠폰명<span class="hiddenVal">couponname</span><span class="hiddenSort">desc</span></th>
								<th>할인가격<span class="hiddenVal">discount</span><span class="hiddenSort">desc</span></th>
								<th>최소사용금액<span class="hiddenVal">minprice</span><span class="hiddenSort">desc</span></th>
								<th>적용회원등급<span class="hiddenVal">fk_membershipname</span><span class="hiddenSort">desc</span></th>
								<th>발급회원번호<span class="hiddenVal">fk_memberno</span><span class="hiddenSort">desc</span></th>
								<th>상태</th><span class="hiddenVal">status</span><span class="hiddenSort">desc</span></th>
								<th>만료일자</th><span class="hiddenVal">endday</span><span class="hiddenSort">desc</span></th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="ecvo" items="${ecList}">
								<tr class="ecouponInfo">
									<td>${ecvo.fk_couponcode}</td>
									<td class="eachcouponcode">${ecvo.eachcouponcode}</td>
									<td>${ecvo.coupvo.couponname}</td>
									<td>${ecvo.coupvo.discount} 원</td>
									<td>${ecvo.coupvo.minprice} 원</td>
									<td>${ecvo.coupvo.fk_membershipname}</td>
									<td>${ecvo.fk_memberno}</td>
									<c:choose>
										<c:when test="${ecvo.status == 0}">
											<td>미사용</td>
										</c:when>
										
										<c:otherwise>
											<td>사용완료</td>
										</c:otherwise>
									</c:choose>
									<td>${ecvo.endday}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div id="divBar" style="background-color: white; margin: 30px;">
						${pageBar}
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<jsp:include page="../managerFooter.jsp" />