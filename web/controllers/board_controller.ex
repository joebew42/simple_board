defmodule SimpleBoard.BoardController do
  use SimpleBoard.Web, :controller

  alias SimpleBoard.Board

  plug :scrub_params, "board" when action in [:create, :update]

  def index(conn, _params) do
    boards = Repo.all(Board)
    render(conn, "index.html", boards: boards)
  end

  def new(conn, _params) do
    changeset = Board.changeset(%Board{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"board" => board_params}) do
    changeset = Board.changeset(%Board{}, board_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "Board created successfully.")
      |> redirect(to: board_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    board = Repo.get!(Board, id)
    render(conn, "show.html", board: board)
  end

  def edit(conn, %{"id" => id}) do
    board = Repo.get!(Board, id)
    changeset = Board.changeset(board)
    render(conn, "edit.html", board: board, changeset: changeset)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = Repo.get!(Board, id)
    changeset = Board.changeset(board, board_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Board updated successfully.")
      |> redirect(to: board_path(conn, :index))
    else
      render(conn, "edit.html", board: board, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = Repo.get!(Board, id)
    Repo.delete!(board)

    conn
    |> put_flash(:info, "Board deleted successfully.")
    |> redirect(to: board_path(conn, :index))
  end
end
