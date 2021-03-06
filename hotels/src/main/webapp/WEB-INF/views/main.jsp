<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- date picker 소스파일 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/datepicker/moment.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/typeahead/typeahead.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/datepicker/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/style/datepicker/tempusdominus-bootstrap-4.min.css" />
<!-- 평점 소스파일 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/star/star.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/style/star/star.css" />


<!-- 	date picker width 버그 수정 -->
<style>
		.bootstrap-datetimepicker-widget.dropdown-menu{
			width:330px;
		}
		
		<!-- typeahead 디자인 -->
		.typeahead,
		.tt-query,
		.tt-hint {
		  border: 2px solid #ccc;
		  outline: none;
		}
		.typeahead {
		  background-color: #fff;
		}
		.typeahead:focus {
		  border: 2px solid #0097cf;
		}
		.twitter-typeahead > .form-control:focus{
			color: #003a70;
			font-weight: bold;
		}
		.tt-menu{
			width:20rem;
			background-color: white;
			border: 1px solid black;
		}
		.tt-dropdown-menu {
		  width: 422px;
		  margin-top: 3px;
		  padding: 8px 0;
		  background-color: #fff;
		  border: 1px solid #ccc;
		  border: 1px solid rgba(0, 0, 0, 0.2);
		  -webkit-border-radius: 8px;
		     -moz-border-radius: 8px;
		          border-radius: 8px;
		  -webkit-box-shadow: 0 5px 10px rgba(0,0,0,.2);
		     -moz-box-shadow: 0 5px 10px rgba(0,0,0,.2);
		          box-shadow: 0 5px 10px rgba(0,0,0,.2);
		}
		
		/* 자동완성(하단) */
		.tt-suggestion {
		  padding: 3px 20px;
		  line-height: 24px;
		  color: gray;
		  text-align: left;
		  
		  /* 텍스트 숨기기 위한 스타일 속성 */
		  text-overflow: ellipsis;
		  white-space: nowrap;
		  overflow: hidden;
		}
		.tt-suggestion:hover{
			background-color:lightgray;
			cursor:hand;
		}
		
		.tt-suggestion.tt-cursor {
		  color: #fff;
		  background-color: #0097cf;
		}
		
		.tt-suggestion p {
		  margin: 0;
		  font-size: 18px;
		  text-align: left;
		}
		
		.twitter-typeahead {
			width: 100%;
		}
		#date-toast{
			position: fixed;
			top: 30px;
			right: 50px;
			z-index: 999;
		}
		#date-toast>.toast-header{
			background-color: #000080;
			color: white;
		}
		
	</style>	

<!-- 	swiper 소스파일 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/style/swiper/swiper.css">
<script src="${pageContext.request.contextPath}/js/swiper/swiper.js"></script>

<!-- 슬라이더 스크립트 -->
<script>
	$(function(){
		var mySwiper = new Swiper ('.swiper-container', {
				autoHeight : true,
				loop : true,
				resizeReInit: true,
				effect: 'fade',
				autoResize: true,
				autoplay: {
				      delay: 2500,
				      disableOnInteraction: false,
				    }
		    })
	})
</script>

<script type="text/javascript">
    $(function () {
    	$("input[name=check_in]").focus(function(){
    	    $("#datetimepicker1").datetimepicker("show");
		});
		$("input[name=check_out]").focus(function(){
			$("#datetimepicker2").datetimepicker("show");
		});
    	
    	var now = new Date();
    	now.setDate(now.getDate()+1);
    	var startday = now;
    	var lastday = null;
    	
        $('#datetimepicker1').datetimepicker({
        	minDate : now,
        	format : 'YYYY-MM-DD'
        });
        $('#datetimepicker2').datetimepicker({
        	minDate : now,
        	format : 'YYYY-MM-DD',
            useCurrent: false
        });
        
        $("#datetimepicker1").on("change.datetimepicker", function (e) {
            $('#datetimepicker2').datetimepicker('minDate', e.date);
            startday = $("#datetimepicker1 input").val();
            dateMath();
        });
        $("#datetimepicker2").on("change.datetimepicker", function (e) {
            lastday = $("#datetimepicker2 input").val();
            dateMath();
        });

    	$("form").submit(function(e){
    		e.preventDefault();
    		var daygap = new Date($("#datetimepicker2 input").val()) - new Date($("#datetimepicker1 input").val());
    		if(daygap < 86400000){
    			$('#date-toast').toast({
                    delay: 3000,
                }).toast('show');
    			$("input[name=check_in]").val("");
    			$("input[name=check_in]").focus();
    		}else{
    			this.submit();
    		}
    	})
		//날짜 차이 구하는 함수
		function dateMath() {
			if(startday != null && lastday!=null){
				var diff = dateDiff(new Date($("#datetimepicker1 input").val()), new Date($("#datetimepicker2 input").val()))
				if(diff>7){
					alert("기간은 7일 이하로 선택해주세요.")
					$("#datetimepicker2 input").val('');
				}
			}
		};
		function dateDiff(_check_in, _check_out) {
			var diffDate_1 = _check_in instanceof Date ? _check_in : new Date(_check_in);
			var diffDate_2 = _check_out instanceof Date ? _check_out : new Date(_check_out);

			diffDate_1 = new Date(diffDate_1.getFullYear(), diffDate_1
					.getMonth() + 1, diffDate_1.getDate());
			diffDate_2 = new Date(diffDate_2.getFullYear(), diffDate_2
					.getMonth() + 1, diffDate_2.getDate());

			var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
			diff = Math.ceil(diff / (1000 * 3600 * 24));
			return diff;
		}
    });
</script>

<!-- Slider main container -->
<div class="swiper-container">
    <!-- Additional required wrapper -->
    <div class="swiper-wrapper">
        <!-- Slides -->
        <div class="swiper-slide"><a href="${pageContext.request.contextPath }/mainview/147"><img width="100%" src="${pageContext.request.contextPath }/img/1.jpg"></a></div>
        <div class="swiper-slide"><a href="${pageContext.request.contextPath }/mainview/152"><img width="100%" src="${pageContext.request.contextPath }/img/2.jpg"></a></div>
        <div class="swiper-slide"><a href="${pageContext.request.contextPath }/mainview/152"><img width="100%" src="${pageContext.request.contextPath }/img/3.jpg"></a></div>
    </div>
</div>

<script>
	var states = [];
	$.ajax({
		type:'post',
		url : "${pageContext.request.contextPath}/region",
		dataType:"json",
		success: function(data){
			var size = Object.keys(data).length;
			for(var i=0; i<size; i++){
				states.push(data[i].region_kor_name);
				states.push(data[i].region_eng_name);
			}
		}
	})
</script>
<!-- 자동완성 스크립트 -->
<script>
$(function(){
	var substringMatcher = function(strs) {
		  return function findMatches(q, cb) {
		    var matches, substringRegex;

		    // an array that will be populated with substring matches
		    matches = [];

		    // regex used to determine if a string contains the substring `q`
		    substrRegex = new RegExp(q, 'i');

		    // iterate through the pool of strings and for any string that
		    // contains the substring `q`, add it to the `matches` array
		    $.each(strs, function(i, str) {
		      if (substrRegex.test(str)) {
		        matches.push(str);
		      }
		    });

		    cb(matches);
		  };
		};
	
	$("input[name=region]").typeahead({
	  hint: true,
	  highlight: true,
	  minLength: 1
	},
	{
	  name: 'states',
	  source: substringMatcher(states)
	});
})
</script>

<div style="height: 20px;"></div>
<style>
	.search-box{
		display: flex;
		max-width: 1100px;
		margin: auto;
	}
</style>
<form action="${pageContext.request.contextPath }/hotel/search">
<div class="search-box">
	<div style="flex-grow: 1"></div>
	<div class="form-group" style="width: 150px;">
		<input type="text" placeholder="지역 검색" name="region" class="form-control" required>
	</div>
	<div style="width: 200px;">
          <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
               <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1" placeholder="체크인" name="check_in" autocomplete="off" required/>
               <div class="input-group-append check_in_btn" data-target="#datetimepicker1" data-toggle="datetimepicker">
                   <div class="input-group-text"><i class="fa fa-calendar"></i></div>
               </div>
           </div>
	</div>
	
	<div style="width: 200px;">
          <div class="input-group date" id="datetimepicker2" data-target-input="nearest">
               <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker2" placeholder="체크아웃" name="check_out" autocomplete="off" required/>
               <div class="input-group-append check_out_btn" data-target="#datetimepicker2" data-toggle="datetimepicker">
                   <div class="input-group-text"><i class="fa fa-calendar"></i></div>
               </div>
           </div>
       </div>
    <div style="width: 150px;">
		  <select class="custom-select"  name="people" required>
		    <option value="1">총 인원 1</option>
		    <option value="2">총 인원 2</option>
		    <option value="3">총 인원 3</option>
		    <option value="4">총 인원 4</option>
		    <option value="5">총 인원 5</option>
		  </select>
	</div>
		<input class="btn btn-danger" type="submit" value="호텔 검색">
		<div style="flex-grow: 1"></div>
</div>
</form>

<style>
	.main-offer{
		width: 1100px;
		margin: auto;
		
		
	}
	.main-offer:after{
		content:"";
		clear: both;
		display: block;
	}
	.left-offer-1{
		float: left;
		width: 695px;
		height: 300px;
		margin-bottom: 10px;
		overflow: hidden;
	}
	.left-offer-2{
		float: left;
		width: 342px;
		height: 300px;
		margin-right: 11px;
		overflow: hidden;
	}
	.left-offer-3{
		float: left;
		width: 342px;
		height: 300px;
		overflow: hidden;
	}
	.right-offer-1{
		float: right;
		width:395px;
		height: 611px;
		overflow: hidden;
	}
	.special{
		width:326px;
		height:106px;
		margin: auto;
		margin-top:50px;
		margin-bottom:50px;
		background-image: url('${pageContext.request.contextPath}/img/main/special.jpg'); 
	}
</style>

<div class="special"></div>
<div class="main-offer">
	<div class="right-offer-1">
		<a href="${pageContext.request.contextPath}/direct/제주" ><img style="width: auto;height: 100%;" alt="제주도" src="${pageContext.request.contextPath}/img/main/jeju.png"></a>
	</div>
	<div class="left-offer-1">
		<a href="${pageContext.request.contextPath}/direct/부산"><img style="width: 100%;height: 100%;" alt="부산" src="${pageContext.request.contextPath}/img/main/busan.png"></a>
	</div>
	<div class="left-offer-2">
		<a href="${pageContext.request.contextPath}/direct/서울"><img style="width: 100%;height: 100%;" alt="서울" src="${pageContext.request.contextPath}/img/main/seoul.png"></a>
	</div>
	<div class="left-offer-3">
		<a href="${pageContext.request.contextPath}/direct/강원"><img style="width: 100%;height: 100%;" alt="강원" src="${pageContext.request.contextPath}/img/main/gangwon.png"></a>
	</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>



<!-- 	팝업알림 -->
  <div class="toast hide" id="date-toast">
    <div class="toast-header">
      숙박기간
    </div>
    <div class="toast-body">
      Check In 날짜가 Check Out 날짜보다 후일일 수 없습니다.
    </div>
  </div>