defmodule EurosServerWeb.DocumentView do
  use EurosServerWeb, :view
  alias EurosServerWeb.DocumentView

  def render("index.json", %{documents: documents}) do
    %{data: render_many(documents, DocumentView, "document.json")}
  end

  def render("show.json", %{document: document}) do
    %{data: render_one(document, DocumentView, "document.json")}
  end

  def render("document.json", %{document: document}) do
    %{id: document.id, url: document.url, body: document.body}
  end
end
