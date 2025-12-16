package com.petplatform.util;

import org.springframework.data.domain.Page;

import java.util.HashMap;
import java.util.Map;

public class PageUtil {

    /**
     * 构建分页响应数据
     */
    public static <T> Map<String, Object> buildPageResponse(Page<T> page) {
        Map<String, Object> response = new HashMap<>();

        response.put("content", page.getContent());
        response.put("currentPage", page.getNumber());
        response.put("totalPages", page.getTotalPages());
        response.put("totalElements", page.getTotalElements());
        response.put("pageSize", page.getSize());
        response.put("hasNext", page.hasNext());
        response.put("hasPrevious", page.hasPrevious());
        response.put("isFirst", page.isFirst());
        response.put("isLast", page.isLast());

        return response;
    }

    /**
     * 计算分页偏移量
     */
    public static int calculateOffset(int page, int size) {
        return page * size;
    }

    /**
     * 生成分页导航HTML
     */
    public static String generatePaginationHtml(int currentPage, int totalPages, String baseUrl) {
        if (totalPages <= 1) {
            return "";
        }

        StringBuilder html = new StringBuilder();
        html.append("<nav aria-label='Page navigation'>");
        html.append("<ul class='pagination'>");

        // 上一页
        if (currentPage > 0) {
            html.append(String.format(
                    "<li class='page-item'><a class='page-link' href='%s?page=%d'>上一页</a></li>",
                    baseUrl, currentPage - 1));
        }

        // 页码
        int start = Math.max(0, currentPage - 2);
        int end = Math.min(totalPages - 1, currentPage + 2);

        for (int i = start; i <= end; i++) {
            if (i == currentPage) {
                html.append(String.format(
                        "<li class='page-item active'><span class='page-link'>%d</span></li>",
                        i + 1));
            } else {
                html.append(String.format(
                        "<li class='page-item'><a class='page-link' href='%s?page=%d'>%d</a></li>",
                        baseUrl, i, i + 1));
            }
        }

        // 下一页
        if (currentPage < totalPages - 1) {
            html.append(String.format(
                    "<li class='page-item'><a class='page-link' href='%s?page=%d'>下一页</a></li>",
                    baseUrl, currentPage + 1));
        }

        html.append("</ul>");
        html.append("</nav>");

        return html.toString();
    }

    /**
     * 验证分页参数
     */
    public static void validatePageParams(Integer page, Integer size) {
        if (page == null || page < 0) {
            throw new IllegalArgumentException("页码不能为空且必须大于等于0");
        }
        if (size == null || size <= 0 || size > 100) {
            throw new IllegalArgumentException("每页大小必须在1-100之间");
        }
    }

    public static Map<String, Object> getPageInfo(Page<?> page) {
        Map<String, Object> pageInfo = new HashMap<>();

        pageInfo.put("currentPage", page.getNumber() + 1); // 当前页（从1开始）
        pageInfo.put("totalPages", page.getTotalPages()); // 总页数
        pageInfo.put("totalElements", page.getTotalElements()); // 总记录数
        pageInfo.put("pageSize", page.getSize()); // 每页大小
        pageInfo.put("isFirst", page.isFirst()); // 是否第一页
        pageInfo.put("isLast", page.isLast()); // 是否最后一页
        pageInfo.put("hasNext", page.hasNext()); // 是否有下一页
        pageInfo.put("hasPrevious", page.hasPrevious()); // 是否有上一页
        pageInfo.put("numberOfElements", page.getNumberOfElements()); // 当前页记录数

        return pageInfo;
    }
}