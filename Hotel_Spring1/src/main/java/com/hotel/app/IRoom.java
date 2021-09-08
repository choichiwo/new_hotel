package com.hotel.app;

import java.util.ArrayList;

public interface IRoom {
	ArrayList<Roominfo> getRoomList();
	ArrayList<Roominfo> getRoomList1(String checkin,String checkout);
	ArrayList<Roomtype> getRoomType();
	void doDeleteRoom(int roomcode);
	void doAddRoom(String roomname,int roomtype,int howmany,int howmuch);
	void doUpdateRoom(int roomcode,String roomname,int roomtype,int howmany,int howmuch);
	void addBooking(int bookcode,int roomcode,int person,String checkin,String checkout, String name,String mobile);
}
