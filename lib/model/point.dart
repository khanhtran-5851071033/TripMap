class Point {
  String stt;
  String manganh;
  String tennganh;
  String tohopmon;
  String diemchuan;
  String ghichu;

  Point(String stt, String manganh, String tennganh, String tohopmon,
      String diemchuan, String ghichu) {
    this.stt = stt;
    this.manganh = manganh;
    this.tennganh = tennganh;
    this.tohopmon = tohopmon;
    this.diemchuan = diemchuan;
    this.ghichu = ghichu;
  }
  @override
  String toString() {
    return this.stt.trim() +
        '\t' +
        this.manganh.trim() +
        '\t' +
        this.tennganh.trim() +
        '\t' +
        this.tohopmon.trim() +
        '\t' +
        this.diemchuan.trim() +
        '\t' +
        this.ghichu.trim() +
        '\n';
  }
}
