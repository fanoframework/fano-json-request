(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit SubmitController;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /submit
     *
     * See Routes/Submit/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TSubmitController = class(TAbstractController)
    public
        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

uses

    SysUtils;

    function TSubmitController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    var i : integer;
        respBody : IResponseStream;
        keyval : PKeyValue;
        params : IReadOnlyList;
    begin
        respBody := response.body();
        params := request.getParsedBodyParams();
        respBody.write('<ul>');
        for i := 0 to params.count -1 do
        begin
            keyval := params.get(i);
            respBody.write('<li>' + format('"%s" : "%s"', [keyval^.key, keyval^.value]) + '</li>');
        end;
        respBody.write('</ul>');
        result := response;
    end;

end.
