
@include('pages.lead.components.title')

<!--description-->
@include('pages.lead.components.description')

<!--attachments-->
@include('pages.lead.components.attachments')



<!--comments-->
<div class="card-comments" id="card-comments">
    <div class="x-heading"><i class="mdi mdi-message-text"></i>Comments</div>
    <div class="x-content">
        @include('pages.lead.components.post-comment')
        <!--comments-->
        <div id="card-comments-container">
            <!--dynamic content here-->
        </div>
    </div>
</div>