import 'dart:async';

import 'package:card/game_internals/board_state.dart';
import 'package:card/game_internals/playing_area.dart';
import 'package:card/game_internals/playing_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class FirestoreController {
  static final _log = Logger('FirebaseController');

  final FirebaseFirestore instance;

  final BoardState boardState;

  late final _matchRef = instance.collection('matches').doc('match_1');

  late final _areaOneRef = _matchRef
      .collection('area')
      .doc('area_one')
      .withConverter<List<PlayingCard>>(
          fromFirestore: _cardsFromFirestore, toFirestore: _cardsToFirestore);

  late final _areaTwoRef = _matchRef
      .collection('area')
      .doc('area_two')
      .withConverter<List<PlayingCard>>(
          fromFirestore: _cardsFromFirestore, toFirestore: _cardsToFirestore);

  StreamSubscription? _areaOneFirestoreSubscription;
  StreamSubscription? _areaTwoFirestoreSubscription;

  StreamSubscription? _areaOneLocalSubscription;
  StreamSubscription? _areaTwoLocalSubscription;

  FirestoreController({required this.instance, required this.boardState}) {
    _areaOneFirestoreSubscription = _areaOneRef.snapshots().listen((snapshot) {
      _updateLocalFromFirestore(boardState.areaOne, snapshot);
    });

    _areaTwoFirestoreSubscription = _areaTwoRef.snapshots().listen((snapshot) {
      _updateLocalFromFirestore(boardState.areaTwo, snapshot);
    });

    _areaOneLocalSubscription = boardState.areaOne.playerChanges.listen((_) {
      _updateFirestoreFromLocalAreaOne();
    });
    _areaTwoLocalSubscription = boardState.areaTwo.playerChanges.listen((_) {
      _updateFirestoreFromLocalAreaTwo();
    });

    _log.fine('initialized');
  }

  void dispose() {
    _areaOneFirestoreSubscription?.cancel();
    _areaTwoFirestoreSubscription?.cancel();
    _areaOneLocalSubscription?.cancel();
    _areaTwoLocalSubscription?.cancel();

    _log.fine('disposed');
  }

  // Firestore에서 오는 Json 값을 PlayingCard로 역직렬화
  List<PlayingCard> _cardsFromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()?['cards'] as List?;

    if (data == null) {
      _log.info('No data found on Firestore, returning empty list');
      return [];
    }

    final list = List.castFrom<Object?, Map<String, Object?>>(data);

    try {
      return list.map((raw) => PlayingCard.fromJson(raw)).toList();
    } catch (e) {
      throw FirebaseControllerException('Failed to parse data Firestore:');
    }
  }

  // Local PlayingCard데이터를 json형식으로 직렬화
  Map<String, Object?> _cardsToFirestore(
      List<PlayingCard> cards, SetOptions? options) {
    return {'cards': cards.map((c) => c.toJson())};
  }

  // area의 로컬 상태에 따라 Firestore를 업데이트
  void _updateLocalFromFirestore(
      PlayingArea area, DocumentSnapshot<List<PlayingCard>> snapshot) {
    _log.fine('Received new data from Firestore (${snapshot.data()})');

    final cards = snapshot.data() ?? [];

    if (listEquals(cards, area.cards)) {
      _log.fine('No change');
    } else {
      _log.fine('Updating local data with Firestore data ($cards)');
      area.replaceWith(cards);
    }
  }

  void _updateFirestoreFromLocalAreaOne() {
    _updateFirestoreFromLocal(boardState.areaOne, _areaOneRef);
  }

  void _updateFirestoreFromLocalAreaTwo() {
    _updateFirestoreFromLocal(boardState.areaTwo, _areaTwoRef);
  }

  Future<void> _updateFirestoreFromLocal(
      PlayingArea area, DocumentReference<List<PlayingCard>> ref) async {
    try {
      _log.fine('Updating Firestore with local data (${area.cards}) ...');
      await ref.set(area.cards);
      _log.fine('... done updating');
    } catch (e) {
      throw FirebaseControllerException(
          'Failed to update Firestore with local data (${area.cards}) : $e');
    }
  }
}

class FirebaseControllerException implements Exception {
  final String message;

  FirebaseControllerException(this.message);

  @override
  String toString() => 'FirebaseControllerException: $message';
}
