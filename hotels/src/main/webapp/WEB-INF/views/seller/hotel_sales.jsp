<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/seller/seller_template/header.jsp"></jsp:include>

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<!-- jquery ui -->
<link href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" rel="Stylesheet"></link>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js" ></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
 		google.charts.load('current', {'packages':['corechart']});
 		google.charts.setOnLoadCallback(drawVisualization);
	
 		function drawVisualization() { 
// 			var arr = [
// 				['월', '개수'],
// 				['2004/06',  165],
// 				['2004/07',  165],
// 				['2004/08',  165]
// 			]

 			var arr = [];
 				arr.push(['날짜', '금액']);
 			<c:forEach var="salesPrice" items="${hotel_price}">
 					arr.push(['${salesPrice.monthly}', ${salesPrice.total}]);
 			</c:forEach>
			
 			var data = google.visualization.arrayToDataTable(arr);
 			var options = {
 					title : '해당월 날짜별 매출',
 					vAxis: {title: 'Price(원)'},
 					hAxis: {title: 'Month'}, 
 					seriesType: 'bars',
 					series: {5: {type: 'line'}}
 				};
	 			var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
	 			chart.draw(data, options);
		}
</script>
<script>
	var chart;
	window.onload = function () {
	
		chart = new CanvasJS.Chart("chartContainer", {
			animationEnabled: true,  
			title:{
				text: "${this_month}월 날짜별 예약 금액"
			},
			axisX:{
				minimum:"1",
				maximum: "31"
			},
			axisY: {
				title: "price",
				valueFormatString: "\###,###,###,##0.##",
				suffix: "원"
			},
			data: [{
				type: "splineArea",
				color: "rgba(54,158,173,.7)",
				markerSize: 7,
				xValueFormatString: 'DD',
				yValueFormatString: "\#,##0.##",
				dataPoints: [
					<c:forEach var="monthPrice" items="${hotel_month_price}">
						{ x: new Date('${monthPrice.monthly}').getDate() , y: ${monthPrice.total} , label:new Date('${monthPrice.monthly}').getDate()} ,
					</c:forEach>
					
				]
			}]
			});
		chart.render();
	}
</script>
<style>
	.chart_page{
		width: 100%;
		height: 500px;
	}
	
	.chart_chart{
		width:49%;
		height:100%;
		display:inline-block;
	}
	
	.chart_table{
		width: 50%;
		height:100%;
		display:inline-block;	
	}
	#chart_div{
		height: 100%;
	}
	.chart_name{
		width: 49%;
		display:inline-block;	
		text-align: center;
		font-size: 40px;
		margin-bottom: 80px;
		margin-top: 50px;
	}
	.chart_page_title{
		width: 100%;
	}
	
</style>

<jsp:include page="/WEB-INF/views/hotel/hotel_template/hotel_header.jsp"></jsp:include>
<div style="height: 20px;"></div>
<div>
	<div class="chart_page_title">
		<div class="chart_name">월별 매출 금액</div>
		<div class="chart_name">월별 매출 건수</div>
	</div>
	<div class="chart_page">
		<div class="chart_chart">
			<div id="chart_div"></div>
		</div>
		<div class="chart_table">
			<table class="table chart_table_size">
				<thead>
					<tr>
						<th class="menu_month">날짜</th>
						<th>건수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="sales" items="${hotel_cnt}">
						<tr>
							<td>${sales.monthly}</td>
							<td>${sales.count}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div style="width: 100%; text-align: center; margin-top: 100px; margin-bottom: 100px;"><h2>(${hdto.hotel_name}) 의 이번달 매출 내역</h2></div>
<div>
	<div id="chartContainer" style="height: 370px; width: 50%; display: inline-block;"></div>
	<div style="width: 49%; display: inline-block;">
	<table class="table chart_table_size">
		<thead>
			<tr>
				<th class="menu_month">날짜</th>
				<th>건수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="sales" items="${hotel_month_cnt}">
				<tr>
					<td>${sales.monthly}</td>
					<td>${sales.count}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</div>


<jsp:include page="/WEB-INF/views/seller/seller_template/footer.jsp"></jsp:include>