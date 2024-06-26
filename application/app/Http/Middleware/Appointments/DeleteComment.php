<?php

/** --------------------------------------------------------------------------------
 * This middleware class handles [delete] precheck processes for appointments
 *
 * @package    Grow CRM
 * @author     NextLoop
 *----------------------------------------------------------------------------------*/

namespace App\Http\Middleware\Appointments;
use App\Models\Appointment;
use App\Permissions\CommentPermissions;
use Closure;
use Log;

class DeleteComment {

    /**
     * The permisson repository instance.
     */
    protected $commentpermissions;

    /**
     * Inject any dependencies here
     *
     */
    public function __construct(CommentPermissions $commentpermissions) {

        //permissions
        $this->commentpermissions = $commentpermissions;

    }

    /**
     * Check user permissions to edit a appointment
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next) {

        //attachement id
        $comment_id = $request->route('commentid');

        //does the appointment exist
        if (!$comment = \App\Models\Comment::Where('comment_id', $comment_id)->first()) {
            Log::error("comment could not be found", ['process' => '[permissions][appointments][delete-comment]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'comment id' => $comment_id ?? '']);
            //just return
            return response()->json([]);
        }

        //check permissions
        if ($comment->commentresource_type == 'appointment') {
            if ($this->commentpermissions->check('delete', $comment_id)) {
                return $next($request);
            }
        }

        //no items were passed with this request
        Log::error("permission denied", ['process' => '[permissions][appointments][delete-comment]', 'ref' => config('app.debug_ref'), 'function' => __function__, 'file' => basename(__FILE__), 'line' => __line__, 'path' => __file__, 'comment id' => $comment_id ?? '']);
        abort(403);
    }
}