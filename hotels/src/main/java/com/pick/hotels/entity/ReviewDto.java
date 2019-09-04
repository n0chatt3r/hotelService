package com.pick.hotels.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReviewDto {
	private int review_no, review_member_no, review_hotel,review_reserve, review_score;
	private String review_content,review_when;
}
