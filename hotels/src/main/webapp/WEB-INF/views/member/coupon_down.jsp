<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.coupon-wrap{
		padding: 100px;
	}
	.my-coupon-wrap{
		text-align: right;
		width: 100%;
	}
	 .coupon_list_download {
      background-image : url('${pageContext.request.contextPath}/resources/image/coupon.png');
      width :547px;
      height : 194px;
      }
      
       .name{
      	text-align: center;
      }
</style>

<script>
	
	
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js"></script>

<div class="coupon-wrap">
	<h1>다운로드 쿠폰함</h1>
	<div class="my-coupon-wrap">
		<a href="coupon_list" class="btn btn-danger can_btn" >내 쿠폰함</a>
	</div>
	<c:forEach var = "cvo" items="${couponVO}"> 
		<table  class="coupon_list_download" >
				<tbody class="coupon_down">
					<tr>
						<td style="font-size: 25px; padding-top: 20px;" class="name">${cvo.coupon_name}</td>
						<td rowspan="4" style="width: 115px;"><a href="#"></a></td>
					</tr>
					<tr>
						<td>${cvo.coupon_price}</td>
					</tr>
					<tr>
						<td>${cvo.coupon_date1.substring(0,11)} ~ ${cvo.coupon_date2.substring(0,11)}</td>
					</tr>
					<tr>
						<td><p>최소 ${cvo.coupon_minimum}원 이상 결제시 사용가능</p></td>
					</tr>
				</tbody>
		</table>
	</c:forEach>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>