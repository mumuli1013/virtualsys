package com.lili.service;

import java.util.List;

import com.lili.domain.GameClass;
import com.lili.domain.GameInfo;
import com.lili.domain.GameUser;

/**
 * @author lili
 *2019年1月12日
 * 
 */
public interface GameService {
	/**
	 * GameClass实体操作
	 * @param gc
	 */
	//新增游戏分类
	void insertGClass(GameClass gc);
	//删除游戏分类
	void deleteGClass(GameClass gc);
	//修改游戏分类
	void updateGClass(GameClass gc);
	//判断游戏分类是否存在
	GameClass isExistGC(GameClass gc);
	//根据ID查询分类
	GameClass findGClassById(int id);
	//查询所有分类
	List<GameClass> findAllGameClass();
	
	/**
	 * GameInfo实体操作
	 */
	//新增游戏到对应的分类
	void insertGameToClass(GameInfo gi);
	//修改游戏信息
	void updateGameInfo(GameInfo gi);
	//删除游戏
	void deleteGameInfo(GameInfo gi);
	//根据ID查询游戏
	GameInfo findGameById(int id);
	//判断游戏是否存在
	GameInfo isExistGame(GameInfo gi);
	//根据分类查找游戏
	List<GameInfo> findGameByClass(GameInfo gi);
	//查询所有分类,放在下拉选项用
	List<GameInfo> findAllGame();
	/**
	 * GameUser实体操作
	 */
	//查看游戏对应的游戏用户信息
	List<GameUser> findGUserAll();
	//判断用户是否存在
	GameUser isExistGUser(int gameId,Integer gameUserId);
	GameUser findUserByName(String name);
	//更新用户
	void updateGUser(GameUser gu);
	
	/**
	 *  分页
	 */
	/**
	 * 分页显示用
	 */
	List<GameUser> findByGId(GameUser gameUser);
}
