package org.ict.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ict.domain.Criteria;
import org.ict.domain.ReplyVO;

public interface ReplyMapper {
	//mapper에서 두개 이상의 파라미터를 받을때는 param어노테이션을 쓴다.
	
	public List<ReplyVO> getList(int bno);
	
	public void create(ReplyVO vo);
	
	public void update(ReplyVO vo);
	
	public void delete(int rno);
	
	public long getBno(int rno);
	
	public void deleteAll(Long bno);

	public List<ReplyVO> getListPage(@Param("bno") int bno, @Param("cri") Criteria cri);
	
	public int count(int bno);
}
