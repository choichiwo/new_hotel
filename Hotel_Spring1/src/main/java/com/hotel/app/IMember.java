package com.hotel.app;

public interface IMember {
	void doSignin(String username,String userid,String passcode1,String mobile);
	int doCheckUser(String userid,String passcode);

}