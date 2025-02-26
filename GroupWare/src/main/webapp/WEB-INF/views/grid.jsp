<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그리드</title>
<script type="text/javascript" src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css"/>
</head>

<body>
	<div class="container">
		<div class="hero-calout">
			<div id="wrapper" class="list">
				<div class="dt-layout-row">
					<div class="dt-layout-cell dt-layout-start">
						<div class="dt-length"><select aria-controls="example" class="dt-input" id="dt-length-0">
							<option value="10">10</option>
							<option value="25">25</option>
							<option value="50">50</option>
							<option value="100">100</option></select>
							<label for="dt-length-0"> entries per page</label>
						</div>
					</div>
					<div class="dt-layout-cell dt-layout-end">
						<div class="dt-search">
							<label for="dt-search-0">Search:</label>
							<input type="search" class="dt-input" id="dt-search-0" placeholder="" aria-controls="example">
						</div>
					</div>
				</div>
				<div class="dt-layout-cell dt-layout-table">
					<div class="dt-layout-cell dt-layout-full">
						<table id="example" class="display nowrap dataTable dtr-inline collapsed" style="width: 100%;" aria-describedby="example_info">
							<colgroup>
								<col data-dt-column="0" style="width: 152.906px;">
							</colgroup>
							<thead>
							<tr>
								<th data-dt-column="0" rowspan="1" colspan="1" class="dt-orderable-asc dt-orderable-desc dt-ordering-asc" aria-sort="ascending">
									<span class="dt-column-title">Name</span>
									<span class="dt-column-order" role="button" aria-label="Name: Activate to invert sorting" tabindex="0"></span>
								</th>
								<th data-dt-column="1" rowspan="1" colspan="1" class="dt-orderable-asc dt-orderable-desc" style="">
									<span class="dt-column-title">Position</span>
									<span class="dt-column-order" role="button" aria-label="Position: Activate to sort" tabindex="0"></span>
								</th>
								<th data-dt-column="2" rowspan="1" colspan="1" class="dt-orderable-asc dt-orderable-desc" style="">
									<span class="dt-column-title">Office</span>
									<span class="dt-column-order" role="button" aria-label="Office: Activate to sort" tabindex="0"></span>
								</th>
								<th data-dt-column="3" class="dt-body-right dt-type-numeric dt-orderable-asc dt-orderable-desc" rowspan="1" colspan="1" style="">
									<span class="dt-column-title">Age</span>
									<span class="dt-column-order" role="button" aria-label="Age: Activate to sort" tabindex="0"></span>
								</th>
								<th data-dt-column="4" class="dt-body-right dt-right dt-orderable-asc dt-orderable-desc" rowspan="1" colspan="1" style="">
									<span class="dt-column-title">Start date</span>
									<span class="dt-column-order" role="button" aria-label="Start date: Activate to sort" tabindex="0"></span>
								</th>
								<th data-dt-column="5" class="dt-body-right dt-type-numeric dt-orderable-asc dt-orderable-desc dtr-hidden" rowspan="1" colspan="1" style="display: none;">
									<span class="dt-column-title">Salary</span>
									<span class="dt-column-order" role="button" aria-label="Salary: Activate to sort" tabindex="0"></span>
								</th>
							</tr>
							</thead>
							
							<tbody>
								<tr>
									<td class="dtr-control" tabindex="0">Thor Walton</td>
									<td class="" style="">Developer</td>
									<td class="" style="">New York</td>
									<td class="dt-body-right dt-type-numeric" style="">61</td>
									<td class="dt-body-right dt-right sorting_1" style="">2013. 8. 11.</td>
									<td class="dt-body-right dtr-hidden dt-type-numeric" style="display: none;">$98,540</td>
								</tr>
								<tr>
									<td class="dtr-control" tabindex="0"></td>
									<td class="" style=""></td><td class="" style=""></td>
									<td class="dt-body-right dt-type-numeric" style=""></td>
									<td class="dt-body-right dt-right sorting_1" style=""></td>
									<td class="dt-body-right dtr-hidden dt-type-numeric" style="display: none;"></td>
								</tr>
								<tr>
									<td class="dtr-control" tabindex="0"></td>
									<td class="" style=""></td><td class="" style=""></td>
									<td class="dt-body-right dt-type-numeric" style=""></td>
									<td class="dt-body-right dt-right sorting_1" style=""></td>
									<td class="dt-body-right dtr-hidden dt-type-numeric" style="display: none;"></td>
								</tr>
							</tbody>
						</table>
						<div class="dt-layout-row">
							<div class="dt-layout-cell dt-layout-start">
								<div class="dt-info" aria-live="polite" id="example_info" role="status">Showing 1 to 10 of 57 entries</div>
							</div>
							<div class="dt-layout-cell dt-layout-end">
								<div class="dt-paging">
									<nav aria-label="pagination">
										<button class="dt-paging-button disabled first" role="link" type="button" aria-controls="example" aria-disabled="true" aria-label="First" data-dt-idx="first" tabindex="-1">«</button>
										<button class="dt-paging-button disabled previous" role="link" type="button" aria-controls="example" aria-disabled="true" aria-label="Previous" data-dt-idx="previous" tabindex="-1">‹</button>
										<button class="dt-paging-button current" role="link" type="button" aria-controls="example" aria-current="page" data-dt-idx="0">1</button>
										<button class="dt-paging-button" role="link" type="button" aria-controls="example" data-dt-idx="1">2</button>
										<button class="dt-paging-button" role="link" type="button" aria-controls="example" data-dt-idx="2">3</button>
										<button class="dt-paging-button" role="link" type="button" aria-controls="example" data-dt-idx="3">4</button>
										<button class="dt-paging-button" role="link" type="button" aria-controls="example" data-dt-idx="4">5</button>
										<button class="dt-paging-button next" role="link" type="button" aria-controls="example" aria-label="Next" data-dt-idx="next">›</button>
										<button class="dt-paging-button last" role="link" type="button" aria-controls="example" aria-label="Last" data-dt-idx="last">»</button>
									</nav>
								</div>
							</div>
						</div>
						<div class="dt-autosize" style="width: 100%; height: 0px;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>







</html>