import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

@service({
    name: "Bookstore Service",
})
namespace Bookstore {
    model Author {
        id: integer;

        @minLength(1)
        surname: string;

        @minLength(1)
        givenName: string;
    }
    model Book {
        @minLength(1)
        id: string;

        @minLength(1)
        title: string;

        @minValue(1)
        price: decimal;

        author: Author;
    }
    @tag("Inventory")
    @route("/inventory")
    namespace Inventory {
        @get op getBook(@path bookId: string): {
            @statusCode statusCode: 200;
            @body book: Book;
        } | {
            @statusCode statusCode: 404;
        };
    }
}
