class ImageObj
{
  String _id;
  String _url;
  String _label;

  ImageObj(this._id, this._url, this._label);

  String get label => _label;

  String get url => _url;

  String get id => _id;

  set label(String value) {
    _label = value;
  }
}