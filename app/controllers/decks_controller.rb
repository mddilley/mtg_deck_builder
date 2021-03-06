class DecksController < ApplicationController

  get '/decks/new' do
    redirect_to_login?
    erb :"/decks/new"
  end

  get '/decks' do
    redirect_to_login?
    @user = current_user
    erb :"/decks/index"
  end

  post '/decks' do
    redirect_to_login?
    if Deck.find_by("name" => params[:name])
      flash[:duplicatedeck] = "A deck with that name already exists. Please choose another name."
      redirect to "/decks"
    elsif Deck.valid_params?("&&", params)
      @user = current_user
      @deck = @user.decks.create(params)
      erb :"/decks/show"
    elsif Deck.valid_params?("||", params)
      flash[:incomplete] = "Invalid input. Please fill out all fields and submit to create a new deck."
      redirect to "/decks"
    end
  end

  get '/decks/:id/edit' do
    redirect_to_login?
    @deck = Deck.find(params[:id])
    deck_owner?(@deck, "/decks/edit")
  end

  get '/decks/:id' do
    redirect_to_login?
    @deck = Deck.find(params[:id])
    deck_owner?(@deck, "/decks/show")
  end

  patch '/decks/:id' do
    redirect_to_login?
    deck = Deck.find(params[:id])
    if deck_owner?(deck)
      Deck.update_deck(deck, params)
      card = Deck.add_card_to_deck(deck, params)
      flash[:cardlimit] = "You may only add four copies of the same card to a single deck (except basic lands)." if Deck.card_repl_limit?(deck, card)
      flash[:deckfull] = "Your deck is full. Please increase deck size to add more cards." if Deck.deck_is_full?(deck)
      redirect to "/decks/#{deck.id}"
    end
  end

  delete '/decks/:id' do
    redirect_to_login?
    deck = Deck.find(params[:id])
    deck.delete if deck_owner?(deck)
    redirect to "/decks"
  end

end
