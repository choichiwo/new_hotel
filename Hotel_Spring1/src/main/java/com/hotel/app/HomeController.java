package com.hotel.app;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping("/login")
	public String goLoing() {
		return "login";
	}
	
//	@RequestMapping(value="/viewinfo", method=RequestMethod.POST)
//	public String viewInfo(HttpServletRequest hsr, Model model) {
//		String userid = hsr.getParameter("userid");
//		String userpw = hsr.getParameter("userpw");
//		model.addAttribute("userid", userid);
//		model.addAttribute("userpw", userpw);
//		return "viewinfo";
//	}
	@RequestMapping(value="/check_user", method=RequestMethod.POST)
	   public String go_room(HttpServletRequest hsr, Model model) {
	      String userid = hsr.getParameter("userid");
	      String userpw = hsr.getParameter("userpw");
	      model.addAttribute("userid", userid);
	      model.addAttribute("userpw", userpw);
	      HttpSession session = hsr.getSession(); // session �궗�슜媛��뒫�븯寃� �븿
	      session.setAttribute("loginid", userid);
	      return "redirect:/booking"; // RequestMapping�쓽 寃쎈줈�씠由�
	   }
	@RequestMapping(value="/booking", method=RequestMethod.GET)
	   public String booking(HttpServletRequest hrs) {
		HttpSession session = hrs.getSession();
		String loginid = (String)session.getAttribute("loginid");
		if(loginid.equals("1234")) {
			return "booking";
		}
		else {
			return "redirect:/home";
		}
	   }
	
   @RequestMapping("/booking")
   public String goRoom() {
      return "booking";
   }

	@RequestMapping("/home")
	public String goHome() {
		return "home";
	}
	@RequestMapping("/newbie")
	public String goJoin() {
		return "newbie";
	}
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String newinfo(@ModelAttribute("pl") ParamList pl) {
		return "home";
	}
	@RequestMapping("/room")
	   public String go_reservation(HttpServletRequest hsr,Model model) {
		HttpSession session = hsr.getSession();
		if(session.getAttribute("loginid")==null) {
			return "redirect:/home";
		}
		// �뿬湲곗꽌 interface�샇異쒗븯怨� 寃곌낵瑜� room.jsp�뿉 �쟾�떖.
		IRoom room=sqlSession.getMapper(IRoom.class);
//		ArrayList<Roominfo> roominfo=room.getRoomList();
//		model.addAttribute("list",roominfo);

		ArrayList<Roomtype> roomtype=room.getRoomType();
		model.addAttribute("roomType",roomtype);
	      return "room"; 
	   }
	@RequestMapping(value ="/getRoomList",method = RequestMethod.POST,
				produces = "application/text; charset=utf-8")
	@ResponseBody
	public String getRoomList(HttpServletRequest hsr) {
		IRoom room=sqlSession.getMapper(IRoom.class);
		ArrayList<Roominfo> roominfo=room.getRoomList();
		// 李얠븘吏� �뜲�씠�꽣濡� JSONArray留뚮뱾湲�
		JSONArray ja = new JSONArray();
		for(int i=0;i<roominfo.size();i++) {
			JSONObject jo= new JSONObject();
			jo.put("roomcode", roominfo.get(i).getRoomcode());
			jo.put("roomname", roominfo.get(i).getRoomname());
			jo.put("typename", roominfo.get(i).getTypename());
			jo.put("howmany", roominfo.get(i).getHowmany());
			jo.put("howmuch", roominfo.get(i).getHowmuch());
			ja.add(jo);
		}
		return ja.toString();
	}
	@RequestMapping(value ="/deleteRoom",method = RequestMethod.POST,
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String deleteRoom(HttpServletRequest hsr) {
		int roomcode=Integer.parseInt(hsr.getParameter("roomcode"));
		IRoom room=sqlSession.getMapper(IRoom.class);
		room.doDeleteRoom(roomcode);
		return "ok";
	}
	@RequestMapping(value ="/addRoom",method = RequestMethod.POST,
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String addRoom(HttpServletRequest hsr) {
		String rname=hsr.getParameter("roomname");
		int rtype=Integer.parseInt(hsr.getParameter("roomtype"));
		int howmany=Integer.parseInt(hsr.getParameter("howmany"));
		int howmuch=Integer.parseInt(hsr.getParameter("howmuch"));
		IRoom room=sqlSession.getMapper(IRoom.class);
		room.doAddRoom(rname, rtype, howmany, howmuch);
		return "ok";
	}
	@RequestMapping(value ="/updateRoom",method = RequestMethod.POST,
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String updateRoom(HttpServletRequest hsr) {
		IRoom room=sqlSession.getMapper(IRoom.class);
		room.doUpdateRoom(Integer.parseInt(hsr.getParameter("roomcode")),
				hsr.getParameter("roomname"),
				Integer.parseInt(hsr.getParameter("roomtype")),
				Integer.parseInt(hsr.getParameter("howmany")), 
				Integer.parseInt(hsr.getParameter("howmuch"))
				);
		return "ok";
	}
	
	@RequestMapping("/logout")
	   public String logout(HttpServletRequest hsr) {
		HttpSession session = hsr.getSession();
		session.invalidate();
	      return "redirect:/";
	   }
	
   @RequestMapping("show_all")
   public String show_all() {
      return "show_all";
   }
}