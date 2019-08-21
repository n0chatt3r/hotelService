package com.pick.hotels.repository;

import javax.mail.Session;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pick.hotels.entity.MemberDto;
import com.pick.hotels.entity.NoticeDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public boolean regist(MemberDto memberDto) {
		try {
			sqlSession.insert("member.regist", memberDto);
			return true;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
			
		}
	}

	@Override
	public MemberDto get(String member_id) {
		return sqlSession.selectOne("member.id_ckeck", member_id);
	}

	
	@Override
	public MemberDto get(int notice_writer) {
		return sqlSession.selectOne("member.get", notice_writer);
	}

	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto result = sqlSession.selectOne("member,login", memberDto);
		return result;
	}

	@Override
	public void lasttime(String member_id) {
		sqlSession.update("member.lasttime", member_id);
		
	}

	@Override
	public void delete(String member_id) {
		sqlSession.delete("member.delete", member_id);
		
	}

	@Override
	public void change(MemberDto memberDto) {
		sqlSession.update("member.change", memberDto);
		
	}

	@Override
	public MemberDto findPassword(MemberDto memberDto) {
		return sqlSession.selectOne("member.find_pw", memberDto);
	}

	
	
	
	
}