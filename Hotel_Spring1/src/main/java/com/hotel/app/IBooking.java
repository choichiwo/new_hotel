package com.hotel.app;


public interface IBooking {
	void doAddBooking(int roomcode, int person, String checkin, String checkout, String summuch, String name,
			String mobile);
}
