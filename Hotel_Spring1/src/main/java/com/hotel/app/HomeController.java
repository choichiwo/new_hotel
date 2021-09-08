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
	@RequestMapping(value ="/join",method = RequestMethod.POST,
			produces = "application/text; charset=utf-8")
	public String doSignin(ParamList pl) {
		IMember member=sqlSession.getMapper(IMember.class);
		member.doSignin(pl.username, pl.userid,pl.passcode1,pl.mobile);
		return "home";
	}
	
//	다른 방법
//	@RequestMapping(value ="/join",method = RequestMethod.POST,
//			produces = "application/text; charset=utf-8")
//	@ResponseBody
//	public String doSignin(HttpServletRequest hsr) {
//		String username=hsr.getParameter("username");
//		String userid=hsr.getParameter("userid");
//		String passcode1=hsr.getParameter("passcode1");
//		String mobile=hsr.getParameter("mobile");
//		IRoom room=sqlSession.getMapper(IRoom.class);
//		room.doSignin(username, userid, passcode1, mobile);
//		return "/";
//	}
	
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
	      String passcode = hsr.getParameter("passcode");
	      //DB에서 유저확인 : 기존유저면 booking 없으면 home으로
	      IMember member=sqlSession.getMapper(IMember.class);
	      int n=member.doCheckUser(userid,passcode);
	      if(n>0) {
	    	  HttpSession session = hsr.getSession();
	    	  session.setAttribute("loginid", userid);
	    	  return "redirect:/booking";
	      } else { //비등록 회원
	    	  return "home";
	      }
	   }
	@RequestMapping(value="/booking", method=RequestMethod.GET)
	   public String booking(HttpServletRequest hrs,Model model) {
		HttpSession session = hrs.getSession();
		IRoom room=sqlSession.getMapper(IRoom.class);
		ArrayList<Roomtype> roomtype=room.getRoomType();
		model.addAttribute("roomType",roomtype);
		String loginid = (String)session.getAttribute("loginid");
		if(loginid==null) {
			return "redirect:/home"; 
		}
		else {
			return "booking";
		}
	   }
	
//   @RequestMapping("/booking")
//   public String go_booking(HttpServletRequest hsr,Model model) {
//	   HttpSession session = hsr.getSession();   
//	   IRoom room=sqlSession.getMapper(IRoom.class);
//	   ArrayList<Roomtype> roomtype=room.getRoomType();
//	   model.addAttribute("roomType",roomtype);
//	   return "booking";
//   }

	@RequestMapping("/home")
	public String goHome() {
		return "home";
	}
	@RequestMapping("/newbie")
	public String goJoin() {
		return "newbie";
	}
//	@RequestMapping(value="/join", method=RequestMethod.POST)
//	public String newinfo(@ModelAttribute("pl") ParamList pl) {
//		return "home";
//	}
	
	
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
			jo.put("typecode", roominfo.get(i).getTypecode());
			ja.add(jo);
		}
		return ja.toString();
	}

	@RequestMapping(value ="/getRoomList1",method = RequestMethod.POST,
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String getRoomList1(HttpServletRequest hsr) {
		IRoom room=sqlSession.getMapper(IRoom.class);
		String checkin=hsr.getParameter("checkin");
		String checkout=hsr.getParameter("checkout");
		int typecode=Integer.parseInt(hsr.getParameter("typecode"));
		ArrayList<Roominfo> roominfo=room.getRoomList1(checkin,checkout,typecode);
		JSONArray ja = new JSONArray();
		for(int i=0;i<roominfo.size();i++) {
			JSONObject jo= new JSONObject();
			jo.put("roomcode", roominfo.get(i).getRoomcode());
			jo.put("roomname", roominfo.get(i).getRoomname());
			jo.put("typename", roominfo.get(i).getTypename());
			jo.put("howmany", roominfo.get(i).getHowmany());
			jo.put("howmuch", roominfo.get(i).getHowmuch());
			jo.put("typecode", roominfo.get(i).getTypecode());
			ja.add(jo);
		}
		return ja.toString();
	}

	@RequestMapping(value ="/getbooking",method = RequestMethod.POST,
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String getbooking(HttpServletRequest hsr) {
		IBooking booking=sqlSession.getMapper(IBooking.class);
		String checkin=hsr.getParameter("checkin");
		String checkout=hsr.getParameter("checkout");
		int typecode=Integer.parseInt(hsr.getParameter("typecode"));
		ArrayList<Bookinginfo> bookinginfo=booking.getBooking(checkin,checkout,typecode);
		JSONArray ja = new JSONArray();
		for(int i=0;i<bookinginfo.size();i++) {
			JSONObject jo= new JSONObject();
			jo.put("bookcode", bookinginfo.get(i).getBookcode());
			jo.put("roomcode", bookinginfo.get(i).getRoomcode());
			jo.put("typecode", bookinginfo.get(i).getTypecode());
			jo.put("roomname", bookinginfo.get(i).getRoomname());
			jo.put("typename", bookinginfo.get(i).getTypename());
			jo.put("person", bookinginfo.get(i).getPerson());
			jo.put("checkin", bookinginfo.get(i).getCheckin());
			jo.put("checkout", bookinginfo.get(i).getCheckout());
			jo.put("summuch", bookinginfo.get(i).getSummuch());
			jo.put("name", bookinginfo.get(i).getName());
			jo.put("mobile", bookinginfo.get(i).getMobile());
			jo.put("howmany", bookinginfo.get(i).getHowmany());
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
	@RequestMapping(value ="/deletBooking",method = RequestMethod.POST,
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String deletBooking(HttpServletRequest hsr) {
		int bookcode=Integer.parseInt(hsr.getParameter("bookcode"));
		IBooking booking=sqlSession.getMapper(IBooking.class);
		booking.doDeleteBooking(bookcode);
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
	@RequestMapping(value ="/updateBooking",method = RequestMethod.POST,
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String updateBooking(HttpServletRequest hsr) {
		IBooking booking=sqlSession.getMapper(IBooking.class);
		booking.doUpdateBooking(Integer.parseInt(hsr.getParameter("roomcode")),
				Integer.parseInt(hsr.getParameter("person")),
				hsr.getParameter("name"),
				hsr.getParameter("mobile")
				);
		return "ok";
	}
	
	@RequestMapping(value ="/addBooking",method = RequestMethod.POST,
			produces = "application/text; charset=utf-8")
	@ResponseBody
	public String addBooking(HttpServletRequest hsr) {
		int roomcode=Integer.parseInt(hsr.getParameter("roomcode1"));
		int person=Integer.parseInt(hsr.getParameter("person"));
		String checkin=hsr.getParameter("checkin");
		String checkout=hsr.getParameter("checkout");
		String summuch=hsr.getParameter("summuch");
		String name=hsr.getParameter("name");
		String mobile=hsr.getParameter("mobile");
		IBooking booking=sqlSession.getMapper(IBooking.class);
		booking.doAddBooking(roomcode, person, checkin, checkout,summuch,name,mobile);
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