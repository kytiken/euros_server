defmodule EurosServer.Spiders do
  @moduledoc """
  The Spiders context.
  """

  import Ecto.Query, warn: false
  alias EurosServer.Repo

  alias EurosServer.Spiders.Crawl

  @doc """
  Returns the list of crawls.

  ## Examples

      iex> list_crawls()
      [%Crawl{}, ...]

  """
  def list_crawls do
    Repo.all(Crawl)
  end

  @doc """
  Gets a single crawl.

  Raises `Ecto.NoResultsError` if the Crawl does not exist.

  ## Examples

      iex> get_crawl!(123)
      %Crawl{}

      iex> get_crawl!(456)
      ** (Ecto.NoResultsError)

  """
  def get_crawl!(id), do: Repo.get!(Crawl, id)

  @doc """
  Creates a crawl.

  ## Examples

      iex> create_crawl(%{field: value})
      {:ok, %Crawl{}}

      iex> create_crawl(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crawl(attrs \\ %{}) do
    %Crawl{}
    |> Crawl.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a crawl.

  ## Examples

      iex> update_crawl(crawl, %{field: new_value})
      {:ok, %Crawl{}}

      iex> update_crawl(crawl, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crawl(%Crawl{} = crawl, attrs) do
    crawl
    |> Crawl.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Crawl.

  ## Examples

      iex> delete_crawl(crawl)
      {:ok, %Crawl{}}

      iex> delete_crawl(crawl)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crawl(%Crawl{} = crawl) do
    Repo.delete(crawl)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crawl changes.

  ## Examples

      iex> change_crawl(crawl)
      %Ecto.Changeset{source: %Crawl{}}

  """
  def change_crawl(%Crawl{} = crawl) do
    Crawl.changeset(crawl, %{})
  end

  alias EurosServer.Spiders.Document

  @doc """
  Returns the list of documents.

  ## Examples

      iex> list_documents()
      [%Document{}, ...]

  """
  def list_documents do
    Repo.all(Document)
  end

  @doc """
  Gets a single document.

  Raises `Ecto.NoResultsError` if the Document does not exist.

  ## Examples

      iex> get_document!(123)
      %Document{}

      iex> get_document!(456)
      ** (Ecto.NoResultsError)

  """
  def get_document!(id), do: Repo.get!(Document, id)

  @doc """
  Creates a document.

  ## Examples

      iex> create_document(%{field: value})
      {:ok, %Document{}}

      iex> create_document(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_document(attrs \\ %{}) do
    %Document{}
    |> Document.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a document.

  ## Examples

      iex> update_document(document, %{field: new_value})
      {:ok, %Document{}}

      iex> update_document(document, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_document(%Document{} = document, attrs) do
    document
    |> Document.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Document.

  ## Examples

      iex> delete_document(document)
      {:ok, %Document{}}

      iex> delete_document(document)
      {:error, %Ecto.Changeset{}}

  """
  def delete_document(%Document{} = document) do
    Repo.delete(document)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking document changes.

  ## Examples

      iex> change_document(document)
      %Ecto.Changeset{source: %Document{}}

  """
  def change_document(%Document{} = document) do
    Document.changeset(document, %{})
  end
end
