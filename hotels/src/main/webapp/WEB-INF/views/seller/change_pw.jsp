<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/seller/seller_template/header.jsp"></jsp:include>
<script
	src="${pageContext.request.contextPath}/js/cryptojs/components/core-min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/cryptojs/components/sha256-min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.form.form-label>fieldset {
	width: 650px;
	text-align: left;
	margin-top: 100px;
	margin-bottom: 100px;
	padding: 20px;
}

.table input {
	width: 190px;
}

.table input[name=btn] {
	width: 100px;
	margin-left: 230px;
}

</style>
<script>
//비밀번호 검사 후 형식에 안맞을시 보조메세지 출력	
$(function(){
	$("input[name=n_seller_pw]").blur(
		function checkPw(){
		    var s_pw = document.querySelector("#sell_pw").value;
		    var regex = /^[a-zA-Z0-9!@#$\-_]{8,15}$/;
	    
		  //정규표현식으로 s_pw값 검사
		    var result = regex.test(s_pw);
		    
		    var div = document.querySelector(".s_pwD");
		
		    if(result) {
		        div.innerHTML = ""
		    }
		    
			//s_pw가 형식에 맞지 않으면 메세지 출력
		    else {
		        div.innerHTML = "<font color = 'gray' size = '2'>8~15자의 영문 대소문자, 숫자, 특수문자(!@#$-_)로 입력해주세요</font>"
	        
	   		 }
		});
	});
	
	$(function() {
		$('#sell_pw').keyup(function() {
			$('font[name=check]').text('');
		}); //#user_pass.keyup
	
		$('#chpass').keyup(function() {
			if ($('#sell_pw').val() != $('#chpass').val()) {
				$('font[name=check]').text('');
				$('font[name=check]').html("암호틀림");
				$("input[name=btn]").prop("disabled", true)
				
			} else {
				$('font[name=check]').text('');
				$('font[name=check]').html("암호맞음");
				$("input[name=btn]").prop("disabled", false)
			}
		}); //#chpass.keyup
	});
	$(function(){
		$("form").submit(function(e){
			e.preventDefault();	
			
			var pw = $("input[name=origin_pw]").val();
			var encPw = CryptoJS.SHA256(pw).toString();
			
			var ck_pw = $("input[name=pw_check]").val();
			var encNPW = CryptoJS.SHA256(ck_pw).toString();
			
			console.log(encPw);
			console.log(encNPW);
			$("input[name=origin_pw]").attr("name","");
			$("input[name=n_seller_pw]").attr("name","");
			var newInput2 = $("<input/>").attr("name","seller_pw").val(encPw).attr("type","hidden");
			var newInput1 = $("<input/>").attr("name","new_seller_pw").val(encNPW).attr("type","hidden");
			$("input[name=pw_check]").attr("name","");
			$(this).append(newInput1);
			$(this).append(newInput2);
			
			this.submit();
		});
	});
</script>

<script type="text/javascript">

		window.history.forward();

		function noBack() {

			window.history.forward();

		}
</script>
<div align="center">
	<c:if test="${param.error eq 'error'}">
		<h4>
			<font color="red"> 잘못된 비밀번호 입니다 </font>
		</h4>
	</c:if>
	<form action="change_pw" method="post" class="form form-label">
		<fieldset>
			<legend>CHECK PASSWORD</legend>
			<table border=1 class="table table-noline">
				<tbody>

					<tr>
						<td><label for="s_pw">PASSWORD</label></td>
						<td><input class="form-control" type="password"
							name="origin_pw" id="s_pw" required></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td><label for="s_pw">PASSWORD</label></td>
						<td><input type="password" class="form-control"
							name="n_seller_pw" id="sell_pw"
							pattern="^[a-zA-Z0-9!@#$\-_]{8,15}$" required>
							<div class="s_pwD"></div></td>
					</tr>
					<tr>
						<td><label>PASSWORD CHECK</label></td>
						<td><input class="form-control" type="password" id="chpass"
							name="pw_check" placeholder="비밀번호 확인" required> <font
							size="3" color="red"></font></td>

					</tr>
					<tr>
						<td colspan="2" class="end_btn"><input class="btn btn-danger btn-block"
							type="submit" value="확인" name="btn"></td>
					</tr>
				</tbody>
			</table>
		</fieldset>
	</form>
</div>

<jsp:include page="/WEB-INF/views/seller/seller_template/footer.jsp"></jsp:include>