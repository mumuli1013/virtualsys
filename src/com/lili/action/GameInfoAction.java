package com.lili.action;

import java.util.List;
import com.lili.domain.GameClass;
import com.lili.domain.GameInfo;
import com.lili.domain.Page;
import com.lili.domain.Pay;
import com.lili.service.GameService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * @author lili
 *2019年1月12日
 * 
 */
public class GameInfoAction extends ActionSupport implements ModelDriven<GameInfo>{
	
	//为ModelDriven提供GameInfo对象
	GameInfo gameInfo = new GameInfo();
	@Override
	public GameInfo getModel() {
		return gameInfo;
	}
	//依赖注入业务层
	private GameService gameService;
	public void setGameService(GameService gameService) {
		this.gameService = gameService;
	}
	//分页
	public String addGameUI() {
		List<GameClass> list = this.gameService.findAllGameClass();
		ActionContext.getContext().getValueStack().set("list", list);
		return "addGameUI";
	}
	public String addGame() {
		GameInfo existGame = this.gameService.isExistGame(gameInfo);
		if(existGame!=null) {
			this.addActionError("游戏已存在");
			return INPUT;
		}else {
			this.gameService.insertGameToClass(gameInfo);
			return "addSuccess";
		}
	}
	
	//删除
	public String delete() {
		gameInfo = this.gameService.findGameById(gameInfo.getId());
		this.gameService.deleteGameInfo(gameInfo);
		return "deleteSuccess";
	}
	//进入修改页面
	public String edit() {
		//获取当前ID所有信息
		gameInfo = this.gameService.findGameById(gameInfo.getId());
		//获取分类
		List<GameClass> list = this.gameService.findAllGameClass();
		ActionContext.getContext().getValueStack().set("list", list);
		return "editSuccess";
	}
	//修改
	public String update() {
		this.gameService.updateGameInfo(gameInfo);
		return "updateSuccess";
	}
	//根据游戏Id查找游戏信息
	public String gameInfoUI() {
		gameInfo = this.gameService.findGameById(gameInfo.getId());
		ActionContext.getContext().getSession().put("gameInfo", gameInfo);
		return "gameInfoUI";
	}
	
	/**
	 * 分页显示
	 */
	private String currentPage;                  //前端传来的当前页码
	public String getCurrentPage() {
		return currentPage;
	}
 
	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}
	public void findPage(List list) {
		//得到当前页
		String currentPage = this.currentPage;
		if(currentPage == null)
			currentPage = "1";
		int pageNum = Integer.parseInt(currentPage);
		Page<GameInfo> page = new Page<GameInfo>();
		page.setBigList(list); //设置 要分页的集合
		page.setCurrentPage(pageNum);
		page.setPageRow(10);
		ActionContext.getContext().getSession().put("page", page);
	}
	public String findAll() {
		List<GameInfo> list = (List<GameInfo>) this.gameService.findAllGame();
		this.findPage(list);
		return "findAll";
	}
}
