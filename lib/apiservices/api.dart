import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflixclone/models/moviedetail.dart';
import 'package:netflixclone/models/nowplayingmodel.dart';
import 'package:netflixclone/models/recomentationmovie.dart';
import 'package:netflixclone/models/searchmodel.dart';
import 'package:netflixclone/models/toprated.dart';
import 'package:netflixclone/models/tvseiesmodel.dart';
import 'package:netflixclone/models/upcomingmovie.dart';

const baseurl = 'https://api.themoviedb.org/3/';
var key = '?api_key=08942f9f83c2133e308efff39e287fa5';
late String endpoint;

class Apiservices {
  Future<Nowplayingmoviemodel> nowplayingmovie() async {
    endpoint = 'movie/now_playing';
    final url = '$baseurl$endpoint?api_key=08942f9f83c2133e308efff39e287fa5';
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      print('success');
      return Nowplayingmoviemodel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('failed to load upcoming movies');
    }
  }

  Future<Upcomingmoviemodel> getupcomingmovie() async {
    endpoint = 'movie/upcoming';
    final url = '$baseurl$endpoint?api_key=08942f9f83c2133e308efff39e287fa5';
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      print('success');
      print(responce.body);
      return Upcomingmoviemodel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('failed to load nowplaying movies');
    }
  }

  Future<Tvseriesmodel> gettoprated() async {
    endpoint = 'tv/top_rated';
    final url = '$baseurl$endpoint?api_key=08942f9f83c2133e308efff39e287fa5';
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      print('success');
      print(responce.body);
      return Tvseriesmodel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('failed to load top rated tv series ');
    }
  }

  Future<Getrecomentationmoviemodel> getpopularmovie() async {
    endpoint = 'movie/popular';
    final url = '$baseurl$endpoint?api_key=08942f9f83c2133e308efff39e287fa5';
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      print('success');
      print(responce.body);
      return Getrecomentationmoviemodel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('failed to load popular movies ');
    }
  }

  Future<Getsearchmoviemodel> getsearchmovie(String moive) async {
    endpoint = 'search/movie?query=$moive';
    final url = '$baseurl$endpoint';
    print('search url is $url');
    final responce = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc"
    });
    if (responce.statusCode == 200) {
      print('success');
      print(responce.body);
      return Getsearchmoviemodel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('failed to load searched movie ');
    }
  }

  Future<Getmoviedetailmodel> getmoviedetails(int moiveid) async {
    endpoint = 'movie/$moiveid';
    final url = '$baseurl$endpoint?api_key=08942f9f83c2133e308efff39e287fa5';
    print('search url is $url');
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      print('success');
      print(responce.body);
      return Getmoviedetailmodel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('failed to load the details of the movie ');
    }
  }

  Future<Getrecomentationmoviemodel> getMovieRecommendation(int movieId) async {
    endpoint = "movie/$movieId/recommendations";
    final url = "$baseurl$endpoint$key";
    print('recomented url is $url');
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      print('success');
      print(responce.body);
      return Getrecomentationmoviemodel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception("Failed to load movie recommendation");
    }
  }

  Future<Gettopratedmoviemodel> getnewandhot() async {
    endpoint = 'movie/top_rated';
    final url = '$baseurl$endpoint?api_key=08942f9f83c2133e308efff39e287fa5';
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      print('success');
      print(responce.body);
      return Gettopratedmoviemodel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('failed to load top rated tv series ');
    }
  }
}
