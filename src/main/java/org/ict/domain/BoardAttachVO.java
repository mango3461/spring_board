package org.ict.domain;

import lombok.Data;

@Data
public class BoardAttachVO {

	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean fileType;
	
	private Long bno;
}
