package com.lili.service;

import java.util.Date;
import java.util.List;
import com.lili.domain.Pay;
import com.lili.domain.RechargeOrder;

/**
 * @author lili
 *2019年1月15日
 * 
 */
public interface PayService {
	//创建订单
	void createPayOrder(Pay pay);
	
	//分页显示
	List<Pay> findById(Pay pay);
	List<Pay> findByIs(Pay pay);
	List<Pay> findAll();
	List<Pay> findAllByStatus(Pay pay);
	List<Pay> findByTime(String startTime,String endTime,Pay pay);
	List<Pay> findAllByTime(String startTime,String endTime);
	List<Pay> findByGameId(Pay pay);
	List<Pay> findGIdByTime(String startTime,String endTime,Pay pay);
	List<Pay> findGIdByStatus(Pay pay);
}
