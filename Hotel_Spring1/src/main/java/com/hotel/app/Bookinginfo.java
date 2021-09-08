package com.hotel.app;

public class Bookinginfo {
	private int bookcode;
	private int roomcode;
    private int person;
    private String checkin;
    private String checkout;
    private String summuch;
    private String name;
    private String mobile;
    private String roomname;
    private String typename;
    private int typecode;
    private int howmany;
	public Bookinginfo() {
	}
	public Bookinginfo(int bookcode, int roomcode, int person, String checkin, String checkout, String summuch,
			String name, String mobile, String roomname, String typename, int typecode, int howmany) {
		super();
		this.bookcode = bookcode;
		this.roomcode = roomcode;
		this.person = person;
		this.checkin = checkin;
		this.checkout = checkout;
		this.summuch = summuch;
		this.name = name;
		this.mobile = mobile;
		this.roomname = roomname;
		this.typename = typename;
		this.typecode = typecode;
		this.howmany = howmany;
	}
	/**
	 * @return the bookcode
	 */
	public int getBookcode() {
		return bookcode;
	}
	/**
	 * @param bookcode the bookcode to set
	 */
	public void setBookcode(int bookcode) {
		this.bookcode = bookcode;
	}
	/**
	 * @return the roomcode
	 */
	public int getRoomcode() {
		return roomcode;
	}
	/**
	 * @param roomcode the roomcode to set
	 */
	public void setRoomcode(int roomcode) {
		this.roomcode = roomcode;
	}
	/**
	 * @return the person
	 */
	public int getPerson() {
		return person;
	}
	/**
	 * @param person the person to set
	 */
	public void setPerson(int person) {
		this.person = person;
	}
	/**
	 * @return the checkin
	 */
	public String getCheckin() {
		return checkin;
	}
	/**
	 * @param checkin the checkin to set
	 */
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	/**
	 * @return the checkout
	 */
	public String getCheckout() {
		return checkout;
	}
	/**
	 * @param checkout the checkout to set
	 */
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	/**
	 * @return the summuch
	 */
	public String getSummuch() {
		return summuch;
	}
	/**
	 * @param summuch the summuch to set
	 */
	public void setSummuch(String summuch) {
		this.summuch = summuch;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the mobile
	 */
	public String getMobile() {
		return mobile;
	}
	/**
	 * @param mobile the mobile to set
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	/**
	 * @return the roomname
	 */
	public String getRoomname() {
		return roomname;
	}
	/**
	 * @param roomname the roomname to set
	 */
	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}
	/**
	 * @return the typename
	 */
	public String getTypename() {
		return typename;
	}
	/**
	 * @param typename the typename to set
	 */
	public void setTypename(String typename) {
		this.typename = typename;
	}
	/**
	 * @return the typecode
	 */
	public int getTypecode() {
		return typecode;
	}
	/**
	 * @param typecode the typecode to set
	 */
	public void setTypecode(int typecode) {
		this.typecode = typecode;
	}
	/**
	 * @return the howmany
	 */
	public int getHowmany() {
		return howmany;
	}
	/**
	 * @param howmany the howmany to set
	 */
	public void setHowmany(int howmany) {
		this.howmany = howmany;
	}
    

}
