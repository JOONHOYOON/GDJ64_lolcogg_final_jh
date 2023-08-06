<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="today" value="<%=new java.util.Date()%>" />
<jsp:include page="/WEB-INF/views/common/top.jsp" />
<!-- Your own style tag or CSS file -->
<link rel="stylesheet"
	href="${path }/resources/css/matchprediction/matchprediction.css">
<!------------------------------------>
<title>승부예측</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param name="navBgColor" value="nav-black" />
	</jsp:include>
	<section>
		<div class="center-1280 background-img mainpage mainHeight bgImgDiv">
			<div class="width-1280 page-margin">
				<div class="mpTitleMargin"></div>
				<div class="mpTitle">
					<p class="subTitle fs-20">MATCH PREDICTION</p>
					<p class="mainTitle fs-35 mainTitleMargin mp">승부예측</p>
					<div class="mpInfo">
						<p class="content fs-20">LCK 10팀의 승패예측, 지금 바로 참여하세요!</p>
						<p class="content fs-20">예측성공 수에 따라 포인트가 지급됩니다.</p>
					</div>
					<p class="title fs-25">
						현재 <span class="title mpCountSpan"><fmt:formatNumber
								value="${playerCount }" pattern="#,###" />명</span> 참여중!
					</p>
				</div>

				<div class="weekChoiceDiv">
					<c:if test="${not empty week }">
						<c:forEach var="w" items="${week }">
							<c:if test="${nowWeek == w.msWeek}">
								<button id="${w.msWeek }" class="weekDiv weekChoice"
									onclick="weekChoice('${w.msWeek}');">
							</c:if>
							<c:if test="${nowWeek > w.msWeek}">
								<button id="${w.msWeek }" class="weekDiv"
									onclick="weekChoice('${w.msWeek}');">
							</c:if>
							<c:if test="${nowWeek < w.msWeek}">
								<button id="${w.msWeek }" class="weekDiv">
							</c:if>
							<c:if test="${!(nowWeek < w.msWeek)}">
								<div class="weekDivInfo">
									<p class="title fs-26 week">${w.msWeek }</p>
									<p class="content fs-16 weekSpan">주차</p>
								</div>
							</c:if>
							<c:if test="${nowWeek < w.msWeek}">
								<div class="weekDivInfo">
									<p class="title fs-26 week closeWeek">${w.msWeek }</p>
									<p class="content fs-16 weekSpan closeWeek">주차</p>
								</div>
							</c:if>
							<c:if test="${nowWeek == w.msWeek}">
								<p class="content fs-12 weekStatus weekChoiceP">진행중</p>
							</c:if>
							<c:if test="${nowWeek < w.msWeek}">
								<p class="content fs-12 weekStatus closeWeek">예정</p>
							</c:if>
							<c:if test="${nowWeek > w.msWeek}">
								<p class="content fs-12 weekStatus">종료</p>
							</c:if>
							</button>
						</c:forEach>
					</c:if>
				</div>

				<!-- 승부예측, 적중률 랭킹, 실시간 채팅 -->
				<div class="mpPageDiv">
					<div class="mpAllDiv">
						<div class="mpDiv">
							<c:if test="${not empty ms}">
								<c:forEach var="m" items="${ms }">
									<%-- ${ms[1] } --%>
									<c:if test="${nowWeek == m.msWeek }">
										<c:if test="${m.msHome != null && m.msAway != null}">
											<fmt:formatDate value="${today}" pattern="yyyy.MM.dd(E)"
												var="todayDate" />
											<fmt:formatDate value="${m.msDate}" pattern="yyyy.MM.dd(E)"
												var="matchDate" />

											<div class="mpDateDiv">
												<c:if test="true">
													<span class="content fs-20">${matchDate }</span>
												</c:if>
												<hr class="dateHr">
											</div>

											<div class="statusTimeDiv">
												<div class="statusDiv">
													<p class="content fs-16">미참여</p>
												</div>
												<p class="content fs-20">
													<fmt:formatDate value="${m.msDate}" pattern="HH:mm" />
												</p>
											</div>
											<!-- 한 경기 시작 -->
											<div id="${m.msNo }" class="mpMatchDiv">
												<div id="${m.msNo }" class="homeDiv">
													<div class="logoDiv">
														<div class="logoImgDiv">
															<c:if test="${m.msHome != null}">
																<img
																	src="${path }/resources/images/logo/${m.msHome}_big.png">
															</c:if>
														</div>
													</div>
													<div class="homeStatusDiv">
														<c:if test="${m.msHome != null }">
															<p class="content">${m.msHome }${m.team.homeRank }위</p>
														</c:if>
														<c:if test="${m.msHome == null }">
															<p class="content">TBD</p>
														</c:if>
														<p class="content fs-40 fw-bold">100%</p>
													</div>
													<div class="homeScoreDiv">
														<p class="title fs-45">${m.msHomeScore }</p>
													</div>
												</div>
												<div id="${m.msNo }" class="awayDiv">
													<div class="awayScoreDiv">
														<p class="title fs-45">${m.msAwayScore }</p>
													</div>
													<div class="awayStatusDiv">
														<c:if test="${m.msAway != null }">
															<p class="content awaySort">${m.msAway }
																${m.team.awayRank }위</p>
														</c:if>
														<c:if test="${m.msAway == null }">
															<p class="content awaySort">TBD</p>
														</c:if>
														<p class="content fs-40 fw-bold awaySort">100%</p>
													</div>
													<div class="awayLogoDiv">
														<div class="logoImgDiv">
															<c:if test="${m.msAway != null}">
																<img
																	src="${path }/resources/images/logo/${m.msAway}_big.png">
															</c:if>
														</div>
													</div>
												</div>
											</div>
											<!-- 한 경기 끝 -->
										</c:if>
									</c:if>
								</c:forEach>
							</c:if>
						</div>
					</div>

					<div class="rankDiv" style="width: 25%;">
						<div class="choiceRankDiv">
							<div class="choiceTitle">
								<p class="title fs-18">적중률 랭킹</p>
								<img src="${path }/resources/images/matchprediction/rank.png"
									width="25px">
							</div>
							<div class="rankContentDiv">
								<div class="rankTrDiv">
									<div class="centerSort" style="width: 15%;">
										<p class="content">순위</p>
									</div>
									<div class="leftSort" style="width: 50%;">
										<p class="content">닉네임</p>
									</div>
									<div class="centerSort" style="width: 20%;">
										<P class="content">적중 수</P>
									</div>
									<div class="centerSort" style="width: 20%; margin-left: 10px;">
										<p class="content">적중률</p>
									</div>
								</div>
								<c:forEach items="${mpSuccess }" var="mpRank" varStatus="status"
									end="9">
									<c:if test="${mpRank.nickname == loginMember.nickname }">
										<div class="rankInfoDiv borderRank">
									</c:if>
									<c:if test="${mpRank.nickname != loginMember.nickname }">
										<div class="rankInfoDiv">
									</c:if>
									<div class="centerSort" style="width: 15%;">
										<p class="title">${status.count }</p>
									</div>
									<div class="leftSort" style="width: 51%;">
										<p class="content">${mpRank.nickname }</p>
									</div>
									<div class="centerSort" style="width: 12%;">
										<P class="content">${mpRank.successPlay }/${mpRank.totalPlay }</P>
									</div>
									<div class="centerSort" style="width: 22%; margin-left: 10px;">
										<p class="content">${mpRank.successPlayPercentage }%</p>
									</div>
							</div>
							</c:forEach>
						</div>
					</div>

					<div class="chatDiv">
						<div class="chatTitle">
							<p class="title fs-18">실시간 채팅</p>
							<img src="${path }/resources/images/matchprediction/chatting.png"
								width="25px">
						</div>
						<button class="content chatBtn fs-20">
							실시간 채팅 참여하기<img
								src="${path }/resources/images/matchprediction/arrow.png"
								width="25px" style="margin-left: 3px;">
						</button>
						<button class="content chatBtn fs-20">
							실시간 채팅 참여하기<img
								src="${path }/resources/images/matchprediction/arrow.png"
								width="25px" style="margin-left: 3px;">
						</button>
					</div>
				</div>
			</div>


			<div class="myDiv">
				<c:if test="${not empty myMpSuccess}">
					<c:forEach var="my" items="${myMpSuccess }">
						<div class="myInfoDiv">
							<p class="title fs-20">나의 적중률 랭킹</p>
							<div class="myInfoDetailDiv">
								<div class="myRank">
									<span class="title fs-75 mpCountSpan"><fmt:formatNumber
											value="${my.rownum }" pattern="#,###" /></span> <span
										class="title fs-40">위</span>
								</div>
								<p class="content fs-18">
									총
									<fmt:formatNumber value="${playerCount }" pattern="#,###" />
									명 참여
								</p>
							</div>
						</div>
						<div class="myInfoDiv">
							<p class="title fs-20">나의 적중 횟수</p>
							<div class="myInfoChartDiv">
								<div class="chart">
									<canvas id="riskFactorChart"></canvas>
								</div>
								<div class="chartInfoDiv">
									<p class="content fs-18">적중 경기 수 ${my.successPlay }/${my.totalPlay }</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty myMpSuccess}">
					<div class="myInfoDiv">
						<p class="title fs-20">나의 적중률 랭킹</p>
						<div class="myInfoDetailDiv">
							<p class="content fs-18">로그인 후 이용하실 수 있습니다.</p>
						</div>
					</div>
					<div class="myInfoDiv">
						<p class="title fs-20">나의 적중 횟수</p>
						<div class="myInfoChartDiv">
							<div class="chartInfoDiv">
								<p class="content fs-18">로그인 후 이용하실 수 있습니다.</p>
							</div>
						</div>
					</div>
				</c:if>
			</div>
			<!-- 댓글 -->
			<div class="qnaCommentDiv">
				<div class="qnaCommentDivSize">
					<p class="titleBlack qnaCommentTitle fs-20">댓글</p>
					<!-- 댓글 작성 -->
					<form>
						<div class="insertCommentDiv">
							<textarea type="text" class="insertComment contentBlack fs-20"
								style="resize: none;"></textarea>
							<div class="countBtnDiv">
								<div class="countBtn">
									<span id="letterSpan" class="contentBlack fs-20">0/150</span>
								</div>
								<div class="iconBtn">
									<div class="emoDiv">
										<ion-icon name="happy-outline"></ion-icon>
										<div class="emo">
											<ul class="emoSort">
												<!-- 보유 이모티콘 -->
												<li><button type="button">
														<img src="/champion/full/Aatrox.jpg" width="65px"
															height="65px"></li>
												</button>
											</ul>
										</div>
									</div>
									<button class="commentBtn content">등록</button>
								</div>
							</div>
						</div>
					</form>


					<!-- 댓글 목록 -->
					<div class="qnaCommentListDiv">
						<div class="commentSort">
							<p class="contentBlack fs-18 newMargin fw-bolder">최신 순</p>
							<p class="contentBlack fs-18">인기 순</p>
						</div class="commentListSort">
						<hr class="hr-1Black hr-op">

						<!-- 베스트 댓글 한 개 -->
				<c:if test="${not empty bestCommentList}">
					<c:forEach var="best" items="${bestCommentList}">
						<div class="commentList">
							<div>
								<img src="${path }/resources/upload/profile/${best.mpcWriter.profile}"
									style="width: 70px; height: 70px; border-radius: 70px;">
							</div>
							<div class="detailDiv">
								<div class="commentDetail">
									<div class="commentInfo">
										<p class="contentBlack fs-20 nickname">${best.mpcWriter.nickname }</p>
										<img src="${path }/resources/images/tier/${best.mpcWriter.tier.tierRulesNo.tierRulesImage}" class="tierImg">
										<div class="bestDiv">
											<p class="content fs-20">BEST</p>
										</div>
									</div>
									<div class="optionDiv">
										<button class="moreIconBtn">
											<ion-icon class="moreIcon" name="ellipsis-horizontal"
												style="font-size: 28px;"></ion-icon>
										</button>
										<ul class="optionUl">
											<li>
												<!-- 작성자 및 관리자 --> <!-- <button><ion-icon class="optionIcon" name="create-outline"></ion-icon>수정</button>
					                                <hr class="hr-1Black hr-op">
					                                <button><ion-icon class="optionIcon" name="trash-bin-outline"></ion-icon>삭제</button> -->

												<!-- 작성자 x -->
												<button>
													<ion-icon class="optionIcon" name="remove-circle-outline"></ion-icon>
													신고
												</button>
											</li>
										</ul>
									</div>
								</div>

								<div>
									<p class="contentBlack fs-20 commentContent">${best.mpcContent }</p>
									<c:if test="${best.mpcEmoNo.emoFilename != null}">
										<img class="emoticon"
											src="${path }/resources/images/emoticon/${best.mpcEmoNo.emoFilename}"
											width="100px" height="100px">
									</c:if>
								</div>
								<div class="dateBuffDiv">

									<div class='insertReplyDiv'>
										<span class="dateSpan"><fmt:formatDate value="${best.mpcDate }" pattern="yyyy.MM.dd HH:mm" /></span>
										<p class='insertReply' onclick='insertReply(event);'>답글쓰기</p>
										<p class='replyCount insertReply'>답글 29</p>
									</div>

									<div class="buffNerfDiv">
										<div class="buffDiv">
											<button class="buffBtn">
												버프
												<ion-icon name="caret-up-circle-outline" class="bnIcon"></ion-icon>
											</button>
											<p class="contentBlack"><fmt:formatNumber value="${best.buffCount }" type="number" /></p>
										</div>
										<div class="nerfDiv">
											<button class="buffBtn">
												너프
												<ion-icon name="caret-down-circle-outline" class="bnIcon"></ion-icon>
											</button>
											<p class="contentBlack"><fmt:formatNumber value="${best.nerfCount }" type="number" /></p>
										</div>
									</div>
								</div>

								<div class='replyDiv'>
									<form class="replyForm">
										<textarea type="text" class="insertComment contentBlack fs-20"
											style="resize: none;"></textarea>
										<div class="countBtnDiv">
											<div class="countBtn">
												<span id="letterSpan" class="contentBlack fs-20">0/150</span>
											</div>
											<div class="iconBtn">
												<div class="emoDiv">
													<ion-icon name="happy-outline"></ion-icon>
													<div class="emo">
														<ul class="emoSort">
															<li><button type="button">
																	<img src="/champion/full/Aatrox.jpg" width="65px"
																		height="65px"></li>
															</button>
														</ul>
													</div>
												</div>
												<button class="commentBtn content">등록</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<hr class="hr-1Black hr-op">
						
						<div class="replyBestAllDiv">
									<c:forEach var="reply" items="${commentList }">
										<c:if test="${reply.mpcRefNo != 0 && best.mpcNo == reply.mpcRefNo}">
											<!-- 대댓글 한 개 시작 -->
											<div class="commentList">
												<div style="width: 80px;"></div>
												<div>
													<img
														src="${path }/resources/upload/profile/${reply.mpcWriter.profile}"
														style="width: 70px; height: 70px; border-radius: 70px;">
												</div>
												<div class="detaildetailDiv">
													<div class="commentDetail">
														<div class="commentInfo">
															<p class="contentBlack fs-20 nickname">${reply.mpcWriter.nickname }</p>
															<img
																src="${path }/resources/images/tier/${reply.mpcWriter.tier.tierRulesNo.tierRulesImage}"
																class="tierImg">
														</div>
														<div class="optionDiv">
															<button class="moreIconBtn">
																<ion-icon class="moreIcon" name="ellipsis-horizontal"
																	style="font-size: 28px;"></ion-icon>
															</button>
															<ul class="optionUl">
																<li>
																	<!-- 작성자 및 관리자 --> <!-- <button><ion-icon class="optionIcon" name="create-outline"></ion-icon>수정</button>
	                                <hr class="hr-1Black hr-op">
	                                <button><ion-icon class="optionIcon" name="trash-bin-outline"></ion-icon>삭제</button> -->

																	<!-- 작성자 x -->
																	<button>
																		<ion-icon class="optionIcon"
																			name="remove-circle-outline"></ion-icon>
																		신고
																	</button>
																</li>
															</ul>
														</div>
													</div>

													<div>
														<p class="contentBlack fs-20 commentContent">
															${reply.mpcContent }</p>
														<c:if test="${reply.mpcEmoNo.emoFilename != null}">
															<img class="emoticon"
																src="${path }/resources/images/emoticon/${reply.mpcEmoNo.emoFilename}"
																width="100px" height="100px">
														</c:if>
													</div>
													<div class="dateBuffDiv">
														<span class="dateSpan"><fmt:formatDate
																value="${reply.mpcDate }" pattern="yyyy.MM.dd HH:mm" /></span>
														<div class="buffNerfDiv">
															<div class="buffDiv">
																<button class="buffBtn">
																	버프
																	<ion-icon name="caret-up-circle-outline" class="bnIcon"></ion-icon>
																</button>
																<p class="contentBlack">
																	<fmt:formatNumber value="${reply.buffCount }"
																		type="number" />
																</p>
															</div>
															<div class="nerfDiv">
																<button class="buffBtn">
																	너프
																	<ion-icon name="caret-down-circle-outline"
																		class="bnIcon"></ion-icon>
																</button>
																<p class="contentBlack">
																	<fmt:formatNumber value="${reply.nerfCount }"
																		type="number" />
																</p>
															</div>
														</div>
													</div>
												</div>
											</div>
											<hr class="hr-1Black hr-op">
											<!-- 대댓글 하나 끝 -->
										</c:if>
									</c:forEach>
								</div>
					</c:forEach>
				</c:if>

						<!-- 댓글 한 개 -->
						<c:forEach var="comment" items="${commentList }">
							<c:if test="${comment.mpcRefNo == 0 }">
								<div class="commentList">
									<div>
										<img
											src="${path }/resources/upload/profile/${comment.mpcWriter.profile}"
											style="width: 70px; height: 70px; border-radius: 70px;">
									</div>
									<div class="detailDiv">
										<div class="commentDetail">
											<div class="commentInfo">
												<p class="contentBlack fs-20 nickname">${comment.mpcWriter.nickname }</p>
												<img
													src="${path }/resources/images/tier/${comment.mpcWriter.tier.tierRulesNo.tierRulesImage}"
													class="tierImg">
											</div>
											<div class="optionDiv">
												<button class="moreIconBtn">
													<ion-icon class="moreIcon" name="ellipsis-horizontal"
														style="font-size: 28px;"></ion-icon>
												</button>
												<ul class="optionUl">
													<li>
														<!-- 작성자 및 관리자 --> <!-- <button><ion-icon class="optionIcon" name="create-outline"></ion-icon>수정</button>
					                                <hr class="hr-1Black hr-op">
					                                <button><ion-icon class="optionIcon" name="trash-bin-outline"></ion-icon>삭제</button> -->

														<!-- 작성자 x -->
														<button>
															<ion-icon class="optionIcon" name="remove-circle-outline"></ion-icon>
															신고
														</button>
													</li>
												</ul>
											</div>
										</div>

										<div>
											<p class="contentBlack fs-20 commentContent">
												${comment.mpcContent }</p>
											<c:if test="${comment.mpcEmoNo.emoFilename != null}">
												<img class="emoticon"
													src="${path }/resources/images/emoticon/${comment.mpcEmoNo.emoFilename}"
													width="100px" height="100px">
											</c:if>
										</div>
										<div class="dateBuffDiv">

											<div class='insertReplyDiv'>
												<span class="dateSpan"><fmt:formatDate
														value="${comment.mpcDate }" pattern="yyyy.MM.dd HH:mm" /></span>
												<p class='insertReply' onclick='insertReply(event);'>답글쓰기</p>
												<p class='replyCount insertReply'>답글 29</p>
											</div>

											<div class="buffNerfDiv">
												<div class="buffDiv">
													<button class="buffBtn">
														버프
														<ion-icon name="caret-up-circle-outline" class="bnIcon"></ion-icon>
													</button>
													<p class="contentBlack">
														<fmt:formatNumber value="${comment.buffCount }"
															type="number" />
													</p>
												</div>
												<div class="nerfDiv">
													<button class="buffBtn">
														너프
														<ion-icon name="caret-down-circle-outline" class="bnIcon"></ion-icon>
													</button>
													<p class="contentBlack">
														<fmt:formatNumber value="${comment.nerfCount }"
															type="number" />
													</p>
												</div>
											</div>
										</div>

										<div class='replyDiv'>
											<form class="replyForm">
												<textarea type="text"
													class="insertComment contentBlack fs-20"
													style="resize: none;"></textarea>
												<div class="countBtnDiv">
													<div class="countBtn">
														<span id="letterSpan" class="contentBlack fs-20">0/150</span>
													</div>
													<div class="iconBtn">
														<div class="emoDiv">
															<ion-icon name="happy-outline"></ion-icon>
															<div class="emo">
																<ul class="emoSort">
																	<li><button type="button">
																			<img src="/champion/full/Aatrox.jpg" width="65px"
																				height="65px"></li>
																	</button>
																</ul>
															</div>
														</div>
														<button class="commentBtn content">등록</button>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
								<hr class="hr-1Black hr-op">
								<!-- 댓글 한 개 끝 -->

								<div class="replyAllDiv">
									<c:forEach var="reply" items="${commentList }">
										<c:if test="${reply.mpcRefNo != 0 && comment.mpcNo == reply.mpcRefNo}">
											<!-- 대댓글 한 개 시작 -->
											<div class="commentList">
												<div style="width: 80px;"></div>
												<div>
													<img
														src="${path }/resources/upload/profile/${reply.mpcWriter.profile}"
														style="width: 70px; height: 70px; border-radius: 70px;">
												</div>
												<div class="detaildetailDiv">
													<div class="commentDetail">
														<div class="commentInfo">
															<p class="contentBlack fs-20 nickname">${reply.mpcWriter.nickname }</p>
															<img
																src="${path }/resources/images/tier/${reply.mpcWriter.tier.tierRulesNo.tierRulesImage}"
																class="tierImg">
														</div>
														<div class="optionDiv">
															<button class="moreIconBtn">
																<ion-icon class="moreIcon" name="ellipsis-horizontal"
																	style="font-size: 28px;"></ion-icon>
															</button>
															<ul class="optionUl">
																<li>
																	<!-- 작성자 및 관리자 --> <!-- <button><ion-icon class="optionIcon" name="create-outline"></ion-icon>수정</button>
	                                <hr class="hr-1Black hr-op">
	                                <button><ion-icon class="optionIcon" name="trash-bin-outline"></ion-icon>삭제</button> -->

																	<!-- 작성자 x -->
																	<button>
																		<ion-icon class="optionIcon"
																			name="remove-circle-outline"></ion-icon>
																		신고
																	</button>
																</li>
															</ul>
														</div>
													</div>

													<div>
														<p class="contentBlack fs-20 commentContent">
															${reply.mpcContent }</p>
														<c:if test="${reply.mpcEmoNo.emoFilename != null}">
															<img class="emoticon"
																src="${path }/resources/images/emoticon/${reply.mpcEmoNo.emoFilename}"
																width="100px" height="100px">
														</c:if>
													</div>
													<div class="dateBuffDiv">
														<span class="dateSpan"><fmt:formatDate
																value="${reply.mpcDate }" pattern="yyyy.MM.dd HH:mm" /></span>
														<div class="buffNerfDiv">
															<div class="buffDiv">
																<button class="buffBtn">
																	버프
																	<ion-icon name="caret-up-circle-outline" class="bnIcon"></ion-icon>
																</button>
																<p class="contentBlack">
																	<fmt:formatNumber value="${reply.buffCount }"
																		type="number" />
																</p>
															</div>
															<div class="nerfDiv">
																<button class="buffBtn">
																	너프
																	<ion-icon name="caret-down-circle-outline"
																		class="bnIcon"></ion-icon>
																</button>
																<p class="contentBlack">
																	<fmt:formatNumber value="${reply.nerfCount }"
																		type="number" />
																</p>
															</div>
														</div>
													</div>
												</div>
											</div>
											<hr class="hr-1Black hr-op">
											<!-- 대댓글 하나 끝 -->
										</c:if>
									</c:forEach>
								</div>
							</c:if>
						</c:forEach>
					</div>



					<!-- 페이지바 -->
					<!-- 데이터 10개 이하 페이지버튼 none처리 -->
					<div class="pageBar">
						<div class="pageAll">
							<ul class="page">
								<li><a href="#">&lt;</a></li>
								<li><a href="#">1</a></li>
								<li><a href="#" class="nowPage">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">&gt;</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script src="${path}/resources/js/jquery-3.7.0.min.js"></script>
	<script src="${path}/resources/js/script_common.js"></script>
	<!-- Your own script tag or JavaScript file -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
	<script>
/* 댓글 작성시간 */
/* function elapsedTime(date) {
  const start = new Date(date);
  const end = new Date();

  const diff = (end - start) / 1000;
  
  const times = [
    { name: '년', milliSeconds: 60 * 60 * 24 * 365 },
    { name: '개월', milliSeconds: 60 * 60 * 24 * 30 },
    { name: '일', milliSeconds: 60 * 60 * 24 },
    { name: '시간', milliSeconds: 60 * 60 },
    { name: '분', milliSeconds: 60 },
  ];

  for (const value of times) {
    const betweenTime = Math.floor(diff / value.milliSeconds);

    if (betweenTime > 0) {
      return `${betweenTime}${value.name} 전`;
    }
  }
  return '방금 전';
} */


/* 댓글 권한 (왜 안돼!!! 수정 필요) */
/* $(document).on("focus", ".insertComment", function(e){
	if('${empty loginMember}'){
		alert("로그인 후 이용할 수 있습니다.");
		$(".insertComment").blur();
	}
}); */

/* 승부예측 */
$(document).on("click", ".mpMatchDiv", function(e) {
	if('${loginMember}' == null){
		if($(e.target).hasClass('homeDiv') || $(e.target).parents('.homeDiv').hasClass('homeDiv')){
			$(e.target).parents('.mpMatchDiv').find('.homeDiv').css("background-color", "#0D0063");
			$(e.target).parents('.mpMatchDiv').find('.awayDiv').css("background-color", "");
			$(e.target).parents('.mpMatchDiv').find('.homeDiv').css("outline", "3px solid var(--lol-teamblue)");
			$(e.target).parents('.mpMatchDiv').find('.awayDiv').css("outline", "3px solid var(--lol-teamblue)");
			let choiceNo = $(e.target).parents('.mpMatchDiv').find('.homeDiv').attr('id');
			let team = 'home';
			$.ajax({
				type: "POST",
				url: "matchprediction/choice",
				data:{
					"choiceNo": choiceNo,
					"team": team,
					"email": '${loginMember.email}'
				},
				dataType: "json",
				success: function(data){
					console.log(data);
				},
				error: function(err){
	    			console.log("요청 실패", err);
	    		}
			})
		} else if($(e.target).hasClass('awayDiv') || $(e.target).parents('.awayDiv').hasClass('awayDiv')){
			$(e.target).parents('.mpMatchDiv').find('.awayDiv').css("background-color", "#490000");
			$(e.target).parents('.mpMatchDiv').find('.homeDiv').css("background-color", "");
			$(e.target).parents('.mpMatchDiv').find('.homeDiv').css("outline", "3px solid var(--lol-teamred)");
			$(e.target).parents('.mpMatchDiv').find('.awayDiv').css("outline", "3px solid var(--lol-teamred)");
			let choiceNo = $(e.target).parents('.mpMatchDiv').find('.homeDiv').attr('id');
			let team = 'away';
			$.ajax({
				type: "POST",
				url: "matchprediction/choice",
				data:{
					"choiceNo": choiceNo,
					"team": team,
					"email": '${loginMember.email}'
				},
				dataType: "json",
				success: function(data){
					console.log(data);
				},
				error: function(err){
	    			console.log("요청 실패", err);
	    		}
			})
		}
	} else{
		alert("로그인 후 이용하실 수 있습니다.");
	}
		
});	


/* 댓글 글자 수 제한 */
$(document).on("keyup", ".insertComment", function(e) {
	let content = $(e.target).val();
    console.log(content);
    // 글자수 세기
    if (content.length == 0 || content == '') {
    	$('#letterSpan').text('0/150');
    } else {
    	$('#letterSpan').text(content.length + '/150');
    }
    
    // 글자수 제한
    if (content.length > 150) {
        $(e.target).val($(e.target).val().substring(0, 150));
        alert('댓글은 150자 이하로 작성해주세요.');
    };
});

/* 댓글 - 수정, 삭제 버튼 토글 */
$(document).on("click", ".moreIconBtn", function(e) {
    const optionUl = $(e.target).closest(".optionDiv").find(".optionUl");
    optionUl.toggle();
});

/* 댓글 수정 */
$(document).on("click", ".cUpBtn", function(e) {
	const qaNo = $(e.target).attr('id');
	console.log($(e.target).closest("ul").attr('id'));
});

/* 대댓글 입력창 */
function insertReply(e) {
    const replyDiv = $(e.target).parent().parent().siblings('.replyDiv');
    replyDiv.toggle(300);
}

/* 이모티콘 추가창 */
$(".emoDiv").on("click", function(e){
     const emo = $(e.target).siblings('.emo');
     emo.toggle();
 });
 
/* 답글 토글 */
$(document).on("click", ".replyCount", function(e) {
	const reply = $(e.target).parent().parent().parent().parent().next().next('.replyAllDiv');
	reply.toggle(100);
});

$(document).on("click", ".replyCount", function(e) {
	const reply = $(e.target).parent().parent().parent().parent().next().next('.replyBestAllDiv');
	reply.toggle();
});

/* chart */
let myMpSuccess = '${myMpSuccess}';
if(myMpSuccess != null){
	let options = {
	    cutoutPercentage: 85,
	    rotation: Math.PI,
	
	    legend: {
	        display: false,
	    },
	    tooltips: {
	        enabled: true,
	    },
	
	};
	
	let totalPlay = [${myMpSuccess[0].successPlay}, `${myMpSuccess[0].totalPlay}-${myMpSuccess[0].successPlay}`];
	let doughnutData = {
	    labels: [
	        "예측성공", "예측실패"
	    ],
	    datasets: [{
	        data: totalPlay,
	        backgroundColor: [
	        "#6454ED", "#ccc"
	        ],
	        hoverBackgroundColor: [
	        "#6454ED", "#ccc"
	        ],
	        borderWidth: 0,
	    }]
	};
	
	$('#riskFactorChartLoading').hide("fast");
	let ctx = $("#riskFactorChart").get(0).getContext("2d");
	
	let riskFactorChart = new Chart(ctx, {
	    type: 'doughnut',
	    data: doughnutData,
	    options: options
	});
}
	
/* 주차 변경하기 */
function weekChoice(week){
	/* 버튼에 클래스 추가 weekChoice, 버튼에 삭제? */
	
	$.ajax({
	    type: "POST",
	    url: "/matchPrediction/week",
	    data: { week: week }, // 옵션 객체로 전달할 데이터는 key: value 형태로 작성해야 함
	    dataType: "json",
	    success: function(data) {
			const mpDiv = $(".mpDiv");
			mpDiv.html('');
			let html = '';
			
			data.forEach(function(item) {
				
				/* 날짜  */
				function getDateFormat() {
				    let d = new Date(item.msDate);
				    return d.getFullYear() + '.' + ((d.getMonth() + 1) > 9 ? (d.getMonth() + 1).toString() : '0' + (d.getMonth() + 1)) + '.' + (d.getDate() > 9 ? d.getDate().toString() : '0' + d.getDate().toString()) + '(' + '일월화수목금토'.charAt(d.getDay()) + ')';
				}
				
				/* 시간 */
				const msDate = item.msDate;
				const date = new Date(msDate);
				const msTime =  new Intl.DateTimeFormat('ko-KR', { hour: '2-digit', minute: '2-digit', hour12: false }).format(date);
				
				if(item.msAway != null && item.msHome != null){
					html += "<div class='mpDateDiv'>";
					html += "<span class='content fs-20'>" + getDateFormat(item.msDate) + "</span>";
					html += "<hr class='dateHr'></div>";
					html += "<div class='statusTimeDiv'>";
					html += "<div class='statusDiv'>";
					html += "<p class='content fs-16'>미참여</p>";
					html += "</div>";
					html += "<p class='content fs-20'>" + msTime + "</p>";
					html += "</div>";
					html += "<div id='${m.msNo }' class='mpMatchDiv'>";
					html += "<div class='homeDiv'>";
					html += "<div class='logoDiv'>";
					html += "<div class='logoImgDiv'>";
					html += (item.msAway != null) ? "<img src='${path}/resources/images/logo/" + item.msHome +"_big.png'>" : "";
					html += "</div></div>";
					html += "<div class='homeStatusDiv'>";
					html += "<p class='content'>";
					html += (item.msHome != null) ? (item.msHome + " " + item.team.homeRank + "위") : "TBD";
					html += "</p>";
					html += "<p class='content fs-40 fw-bold'>100%</p></div>";
					html += "<div class='homeScoreDiv'>";
					html += "<p class='title fs-45'>" + item.msHomeScore + "</p>";
					html += "</div></div>";
					
					html += "<div class='awayDiv'>";
					html += "<div class='awayScoreDiv'>";
					html += "<p class='title fs-45'>" + item.msAwayScore + "</p>";
					html += "</div>";
					html += "<div class='awayStatusDiv'>";
					html += "<p class='content awaySort'>";
					html += (item.msAway != null) ? (item.msAway + " " + item.team.awayRank + "위") : "TBD";
					html += "</p>";
					html += "<p class='content fs-40 fw-bold awaySort'>100%</p>";
					html += "</div>";
					html += "<div class='awayLogoDiv'>";
					html += "<div class='logoImgDiv'>";
					html += (item.msAway != null) ? "<img src='${path}/resources/images/logo/" + item.msAway +"_big.png'>" : "";
					html += "</div></div></div></div>";
				}
			});
			mpDiv.append(html);
			
			$(".weekDiv").removeClass("weekChoice");
			$(".weekDiv").each(function() {
				const weekChoice = $(this).attr('id')
				if(weekChoice == week){
					$(this).addClass("weekChoice");
				}
			});
			
	    },
	    error: function(err) {
	        console.log("요청 실패", err);
	    }
	});
}

</script>
	<!-- icon -->
	<script type="module"
		src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule
		src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	<!-------------------------------------------->
</body>
</html>
