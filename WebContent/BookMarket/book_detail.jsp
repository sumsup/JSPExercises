<%@ page import="ch04.com.dao.BookRepository"%>
<%@ page import="ch04.com.dto.Book"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="exceptionNoBookId.jsp" %>
<jsp:useBean id="booksRepo" class='ch04.com.dao.BookRepository'></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Book Detail</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>

<body>

<%--<%! // 전역 변수와 전역 메서드를 선언.--%>
<%--	--%>
<%--	Book book = new Book(); // 저장할 책 필드.--%>
<%--	--%>
<%--	// 이렇게 전역 메서드를 선언해서 사용해도 되고.--%>
<%--	public Book getBookById(String bookId, BookRepository booksRepo) {--%>
<%--			--%>
<%--		// books 를 돌면서 bookId에 해당 하는 것을 넣어서 리턴.--%>
<%--		ArrayList<Book> bookList = booksRepo.getListOfBooks();--%>
<%--		--%>
<%--		Book book = null;--%>
<%--		--%>
<%--		// Id 값에 해당하는 book 인스턴스를 가져오기.--%>
<%--		for (int i = 0; i < bookList.size(); i++) {--%>

<%--			String searchingBookId = bookList.get(i).getBookId(); // 책 아이디 조회.--%>
<%--			--%>
<%--			if(searchingBookId.equals(bookId)) { // 찾은 책 아이디랑 전달받은 책 아이디랑 같으면.--%>
<%--				--%>
<%--				// 책 정보를 변수에 할당.--%>
<%--				book = bookList.get(i);--%>
<%--			--%>
<%--			// 이때 위의 if 조건문에서는 == 으로 비교하지 않고 equals로 비교한다.--%>
<%--			// equals는 값으로 비교하고. == 는 주소값으로 비교한다.--%>
<%--							--%>
<%--			}--%>
<%--			--%>
<%--			break;--%>
<%--			--%>
<%--		}--%>
<%--		--%>
<%--		return book;--%>
<%--		--%>
<%--	} --%>
<%--	--%>
<%--	--%>
<%--%>--%>


<%

	Book book = new Book();
	// 쿼리스트링에서 bookId 값을 가져오기.
	String bookId = request.getParameter("id"); // ex) k1234
	System.out.println("조회할 책 id : " + bookId);
	
	//book = booksRepo.getBookById(bookId); // 이 코드는 jspBean 에서 가지고 오는 것.

	//book = getBookById(bookId, booksRepo); // 이 코드는 위의 선언문에 선언된 메서드를 이용하는 것.

	// 선언문이나 빈을 이용하지 않고 아래와 같이 날코딩으로 진행해도 된다.
	// 궁금하면 바로 위 book 객체를 불러오는 코드를 주석 처리하고 아래 코드 주석을 해제한 후에
	// 테스트 해볼 것.
	ArrayList<Book> bookList = booksRepo.getInstance().getListOfBooks();
	System.out.println("=== 불러온 전체 책 리스트 ===");
	for (Book bookDTO : bookList) {
		System.out.println("===========================\n");
		System.out.println("책 id : " + bookDTO.getBookId());
		System.out.println("저자 : " + bookDTO.getAuthor());
		System.out.println("카테고리 : " + bookDTO.getCategory());
		System.out.println("상태 : " + bookDTO.getCondition());
		System.out.println("이름 : " + bookDTO.getName());
		System.out.println("설명 : " + bookDTO.getDescription());
		System.out.println("출판사 : " + bookDTO.getPublisher());
		System.out.println("페이지수 : " + bookDTO.getTotalPages());
		System.out.println("재고수 : " + bookDTO.getUnitInStock());
	}

	boolean isMatchedBooKId = false;
	// Id 값에 해당하는 book 인스턴스를 가져오기.
	System.out.println("\n***id 일치하는 책 찾기 시작!***");
	for (int i = 0; i < bookList.size(); i++) {
		System.out.println("===========================\n");
		System.out.println("책 id : " + bookList.get(i).getBookId());
		System.out.println("저자 : " + bookList.get(i).getAuthor());
		System.out.println("카테고리 : " + bookList.get(i).getCategory());
		System.out.println("상태 : " + bookList.get(i).getCondition());
		System.out.println("이름 : " + bookList.get(i).getName());
		System.out.println("설명 : " + bookList.get(i).getDescription());
		System.out.println("출판사 : " + bookList.get(i).getPublisher());
		System.out.println("페이지수 : " + bookList.get(i).getTotalPages());
		System.out.println("재고수 : " + bookList.get(i).getUnitInStock());

		String searchingBookId = bookList.get(i).getBookId(); // 책 아이디 조회.
		
		if (bookId.equals(searchingBookId)) { // 찾은 책 아이디랑 전달받은 책 아이디랑 같으면.

			System.out.println("\n*** 일치하는 책 id 를 찾았습니다! ***\n");
			// 책 정보를 변수에 할당.
			book = bookList.get(i);
			isMatchedBooKId = true;
			break;
		}

	}

	if (!isMatchedBooKId) { // 찾은 책 아이디랑 전달받은 책 아이디랑 같지 않으면.
		System.out.println("\n*** 일치하는 책 id 를 찾지 못했습니다... ***\n");
		throw new NullPointerException("*** 일치하는 책 id 를 찾지 못했습니다... ***");
	}
	
	// 위에서 테스트 해본 바와 같이 bookId를 이용해서 book 객체를 찾는 방법은
	// 세가지가 있었다.
	
	// 1. 자바파일에 메서드를 만들어서 조회하기. BookRepository.java에.
	// 2. "<%!" 로 시작하는 선언문에 전역 메서드를 정의하고 호출해서 조회하기.
	// 3. "<%" 스크립틀릿에서 직접 조회하기.
	
	// 가장좋은 방법은 1번. 자바파일에 메서드를 만드는 것.
	// 당연히 이렇게 해야 함.
	// 자바 파일에 만들어 놓으면 다른 JSP 페이지들에서도 자바빈에서 간편하게 불러올 수 있기 때문.
	// 그러나 코드를 손가는대로 더럽게 짜보는 연습도 해야 나중에 최적화된 패턴에 응용력이 생기게 될 듯.
		
%>

	<%@include file="include/header.jsp" %>
<style>
	.detail {
		display : block;
	}
	.contents_body {
		margin-top: 20px;
		padding: 0px;
	}
	.main-box {
		display: inline-block;
		float : left;
		width : 65%;
		margin-left: 20px;
	}
	.img_div {
		float : left;
		width : 30%;
	}
</style>
	<div class='container contents_body'>

		<div class='img_div detail'>
			<img src="../resources/book_img/<%= book.getFilename()%>" style="width: 100%;">
		</div>
		<div class="main-box detail">
			<h3>[<%= book.getCategory() %>] <%= book.getName() %></h3>
			<p> <%= book.getDescription() %></p>

			<p><b>도서코드 : </b><%= book.getBookId() %> : <%= bookId %></p>
			<p><b>출판사 : </b><%= book.getPublisher() %></p>
			<p><b>저자 : </b><%= book.getAuthor() %></p>
			<p><b>재고수 : </b><%= book.getUnitInStock() %></p>
			<p><b>총 페이지 수 : </b><%= book.getTotalPages() %></p>
			<p><b>출판일 : </b><%= book.getReleaseDate() %></p>
			<h4><%= book.getUnitPrice() %>원</h4>
			<form name="addForm" action="./addCart.jsp?id=<%=book.getBookId()%>" method="post">
				<a href='#' class='btn btn-secondary' role='button' onclick="addCart()">장바구니 담기 &raquo;</a>
				<a href='books.jsp' class='btn btn-secondary' role='button'>도서목록 &raquo;</a>
			</form>
		</div>
	
	</div>
	<div class="detail">
		<hr>
	</div>

	<%@include file="include/footer.jsp" %>
	
</body>
<script>
	function addCart() {
		var isAddCart = confirm("장바구니에 추가 하시겠습니까?");

		if (isAddCart) { // 장바구니에 추가를 선택.
			document.addForm.submit();
		} else {
			document.addForm.reset();
		}// 아니오를 선택.
	}
</script>

</html>