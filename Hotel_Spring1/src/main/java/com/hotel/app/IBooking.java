package com.hotel.app;

import java.util.ArrayList;

public interface IBooking {
	ArrayList<Bookinginfo> getBooking();
	void doAddBooking(int roomcode, int person, String checkin, String checkout, String summuch, String name,
			String mobile);
}
