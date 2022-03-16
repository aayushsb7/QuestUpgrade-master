dotnet
{
    assembly("System.Net.Http")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b03f5f7f11d50a3a';

        type("System.Net.Http.StringContent"; "StringContent")
        {
        }

        type("System.Net.Http.HttpResponseMessage"; "HttpResponseMessage")
        {
        }

        type("System.Net.Http.HttpContent"; "HttpContent")
        {
        }

        type("System.Net.Http.HttpClient"; "HttpClient")
        {
        }
    }

    assembly("System.Web")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b03f5f7f11d50a3a';

        type("System.Web.HttpUtility"; "HttpUtility")
        {
        }
    }

    assembly("mscorlib")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Text.Encoding"; "Encoding")
        {
        }

        type("System.String"; "String")
        {
        }

        type("System.Array"; "Array")
        {
        }

        type("System.Object"; "Object")
        {
        }
    }

    assembly("System")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Uri"; "Uri")
        {
        }
    }

}
