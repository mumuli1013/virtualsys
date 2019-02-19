package com.lili.service.impl;

import java.util.Date;
import java.util.List;

import com.lili.dao.PayDao;
import com.lili.domain.Pay;
import com.lili.service.PayService;

/**
 * @author lili
 *2019年1月15日
 * 
 */
public class PayServiceImpl implements PayService {
	private PayDao payDao;
	public void setPayDao(PayDao payDao) {
		this.payDao = payDao;
	}
	@Override
	public void createPayOrder(Pay pay) {
		Date currTime = new Date();
		pay.setPayTime(currTime);
		this.payDao.createPayOrder(pay);
	}
	@Override
	public List<Pay> findById(Pay pay) {
		return this.payDao.findById(pay);
	}
	@Override
	public List<Pay> findByIs(Pay pay) {
		return this.payDao.findByIS(pay);
	}
	@Override
	public List<Pay> findAll() {
		return this.payDao.findAll();
	}
	@Override
	public List<Pay> findAllByStatus(Pay pay) {
		return this.payDao.findAllByStatus(pay);
	}
	@Override
	public List<Pay> findByTime(String startTime, String endTime, Pay pay) {
		return this.payDao.findByTime(startTime,endTime,pay);
	}
	@Override
	public List<Pay> findAllByTime(String startTime, String endTime) {
		return this.payDao.findAllByTime(startTime,endTime);
	}
	@Override
	public List<Pay> findByGameId(Pay pay) {
		return this.payDao.findByGameId(pay);
	}
	@Override
	public List<Pay> findGIdByTime(String startTime,String endTime,Pay pay) {
		return this.payDao.findGIdByTime(startTime, endTime, pay);
	}
	@Override
	public List<Pay> findGIdByStatus(Pay pay) {
		return this.payDao.findGIdByStatus(pay);
	}

}
