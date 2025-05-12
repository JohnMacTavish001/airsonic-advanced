<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<table>
    <tr>
        <c:if test="${not empty model.musicFolder}">
            <td style="padding-right: 2em">
                <spring:theme code='detailColor' var="resolvedThemeColor"/>
                <c:set var="finalHexColor" value="#${resolvedThemeColor}"/>
                <div style="border:1px solid '${finalHexColor}'; padding-left: 0.5em;padding-right: 0.5em">
                        ${fn:escapeXml(model.musicFolder.name)}
                </div>
            </td>
        </c:if>

        <c:if test="${model.listType ne 'random'}">
            <c:url value="home.view" var="previousUrl">
                <c:param name="listType" value="${model.listType}"/>
                <c:param name="listOffset" value="${model.listOffset - model.listSize}"/>
                <c:param name="genre" value="${model.genre}"/>
                <c:param name="decade" value="${model.decade}"/>
            </c:url>
            <c:url value="home.view" var="nextUrl">
                <c:param name="listType" value="${model.listType}"/>
                <c:param name="listOffset" value="${model.listOffset + model.listSize}"/>
                <c:param name="genre" value="${model.genre}"/>
                <c:param name="decade" value="${model.decade}"/>
            </c:url>

            <c:if test="${fn:length(model.albums) gt 0}">
                <td style="padding-right:0.5em">
                    <fmt:message key="home.albums">
                        <fmt:param value="${model.listOffset + 1}"/>
                        <fmt:param value="${model.listOffset + fn:length(model.albums)}"/>
                    </fmt:message>
                </td>

                <c:if test="${model.listOffset gt 0}">
                    <td><a href="${previousUrl}"><img src="<spring:theme code='backImage'/>" alt=""></a></td>
                </c:if>

                <c:if test="${fn:length(model.albums) eq model.listSize}">
                    <td><a href="${nextUrl}"><img src="<spring:theme code='forwardImage'/>" alt=""></a></td>
                </c:if>
                <td style="padding-right: 2em">
                </td>
            </c:if>

            <c:if test="${model.listType eq 'decade'}">
                <td>
                    <fmt:message key="home.decade.text"/>
                </td>
                <td style="padding-right: 2em">
                    <select name="decade" onchange="location='home.view?listType=${model.listType}&amp;decade=' + options[selectedIndex].value">
                        <c:forEach items="${model.decades}" var="decade">
                            <option
                            ${decade eq model.decade ? "selected" : ""} value="${decade}">${decade}</option>
                        </c:forEach>
                    </select>
                </td>
            </c:if>
            <c:if test="${model.listType eq 'genre'}">
                <td>
                    <fmt:message key="home.genre.text"/>
                </td>
                <td style="padding-right: 2em">
                    <select name="genre" onchange="location='home.view?listType=${model.listType}&amp;genre=' + encodeURIComponent(options[selectedIndex].value)">
                        <c:forEach items="${model.genres}" var="genre">
                            <option ${genre.name eq model.genre ? "selected" : ""} value="${genre.name}">${genre.name} (${genre.albumCount})</option>
                        </c:forEach>
                    </select>
                </td>
            </c:if>
        </c:if>

        <td style="padding-right: 2em;">
            <a href="javascript:refresh()">
                <img src="<spring:theme code='refreshImage'/>" alt="Refresh" style="height:16px;">
                <fmt:message key="common.refresh"/>
            </a>
        </td>

        <c:if test="${not empty model.albums}">
            <td>
                <a href="javascript:playShuffle()">
                  <img src="<spring:theme code='shuffleImage'/>" alt="Shuffle" style="height:16px;">
                  <fmt:message key="home.shuffle"/>
                </a>
            </td>
        </c:if>
    </tr>
</table>
