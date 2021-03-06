package com.pick.hotels.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class AttractionListVO {
    private int attraction_no; 
	private String attraction_name, attraction_addr1, attraction_addr2, attraction_file_name;
}
