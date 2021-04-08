package org.ict.service;

import java.util.List;

import org.ict.domain.Criteria;
import org.ict.domain.ReplyVO;
import org.ict.mapper.BoardMapper;
import org.ict.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private BoardMapper boardmapper;
	
	@Transactional
	@Override
	public void addReply(ReplyVO vo) {
		mapper.create(vo);
		Long bno = (long) vo.getBno();
		boardmapper.updateReplyCount(bno, +1);
	}

	@Override
	public List<ReplyVO> listReply(int bno) {
		return mapper.getList(bno);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.update(vo);
	}

	@Transactional
	@Override
	public void removeReply(int rno) {
		Long bno = mapper.getBno(rno);
		mapper.delete(rno);
		boardmapper.updateReplyCount(bno, -1);
	}

	@Override
	public List<ReplyVO> getListPage(int bno, Criteria cri) {
		return mapper.getListPage(bno, cri);
	}

	@Override
	public int count(int bno) {
		return mapper.count(bno);
	}

}
