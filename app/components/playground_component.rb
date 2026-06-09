# A thin, reusable shell for an interactive in-browser demo (the JavaScript port
# of an article's Elixir program). It supplies the consistent frame — card,
# optional title, a Run button, and an output pane — and yields a body where the
# author drops bespoke inputs and an inline <script>.
#
# JS contract (all scoped to the section's id):
#   #<id>                        the root <section>
#   [data-playground-run]        the Run button
#   [data-playground-output]     the output <pre> to write results into
#
# Example (in a file-backed app/views/post_content/*.html.erb article):
#
#   <%= render PlaygroundComponent.new(id: "fib", title: "Fibonacci") do %>
#     <label>n <input id="fib-n" type="number" value="10"></label>
#   <% end %>
#   <script>
#     (() => {
#       const root = document.getElementById("fib");
#       const out  = root.querySelector("[data-playground-output]");
#       root.querySelector("[data-playground-run]").addEventListener("click", () => {
#         const n = Number(root.querySelector("#fib-n").value);
#         out.textContent = fib(n);
#       });
#     })();
#   </script>
class PlaygroundComponent < ApplicationComponent
  def initialize(id:, title: nil, run_label: "Run ▶")
    @id = id
    @title = title
    @run_label = run_label
  end
end
