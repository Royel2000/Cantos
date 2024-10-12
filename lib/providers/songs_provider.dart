
import '../data/data.dart';
import '../models/songs_model.dart';

class SongsProvider{
  Future<List<SongModel>> cargarSongs() async {
    try {
      final Map<String, dynamic> dataCancionero = decodedData;
      final List<SongModel> song = [];
      dataCancionero.forEach((id, prod) {
        final prdTemp = SongModel.fromJson(prod);
        prdTemp.id = id;

        song.add(prdTemp);
      });
      return song;
    } catch (error) {
      return [];
    }
  }
}
