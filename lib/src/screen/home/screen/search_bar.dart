import 'package:app/src/screen/home/bloc/media_list_bloc.dart';
import 'package:app/src/screen/home/bloc/media_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_bloc.dart';

AppBar buildSearchBar(TextEditingController textEditingControler) {
  return AppBar(
    title: BlocBuilder<PhotoSearchBloc, PhotoSearchState>(
      builder: (BuildContext context, state) {
        if (state is InitialSearchState) {
          return Row(
            children: [
              Expanded(
                child: Text(''),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => BlocProvider.of<PhotoSearchBloc>(context)
                    .add(SearchButtonEvent()),
              ),
            ],
          );
        }
        if (state is TypingState) {
          return Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => BlocProvider.of<PhotoSearchBloc>(context)
                    .add(BackArrowEvent()),
              ),
              Expanded(
                child: Stack(
                  alignment: const Alignment(1.0, 1.0),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: textEditingControler,
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          BlocProvider.of<MediaListBloc>(context)
                              .add(SearchSubmitEvent(keyWord: value));
                          BlocProvider.of<PhotoSearchBloc>(context)
                              .add(SubmitEvent(keyWord: value));
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => textEditingControler.clear(),
                      icon: Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (state is SearchedState) {
          return Row(
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => {
                        BlocProvider.of<MediaListBloc>(context)
                            .add(BackToShowListEvent()),
                        BlocProvider.of<PhotoSearchBloc>(context)
                            .add(BackArrowEvent()),
                      }),
              Expanded(
                child: GestureDetector(
                  child: Text('${state.keyWord}'),
                  onTap: () => BlocProvider.of<PhotoSearchBloc>(context)
                      .add(SearchButtonEvent()),
                ),
              ),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
          );
        } else {
          return Text('Something wrong');
        }
      },
    ),
  );
}
