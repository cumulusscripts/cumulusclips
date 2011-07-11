<?php

View::AddMeta ('baseURL', HOST);
View::AddSidebarBlock ('recent_posts.tpl');
View::Header();

?>

<h1><?=$member->username?></h1>

<div id="message"></div>

<div class="block">
 
    <div id="profile-avatar">
        <img src="<?=$member->avatar?>" alt="<?=$member->username?>" />
        <p><a class="button-small subscribe" data-member="<?=$member->user_id?>" data-type="<?=$subscribe_text?>" href=""><span><?=Language::GetText($subscribe_text)?></span></a></p>
    </div>
    <div id="profile-info">
        <p>
            <a href="<?=HOST?>/myaccount/message/send/<?=$member->username?>/" title="<?=Language::GetText('send_message')?>"><?=Language::GetText('send_message')?></a>&nbsp;&nbsp;&nbsp;
            <a class="flag" data-type="member" data-id="<?=$member->user_id?>" href="" title="<?=Language::GetText('report_abuse')?>"><?=Language::GetText('report_abuse')?></a>&nbsp;&nbsp;&nbsp;
            <a href="<?=HOST?>/feed/<?=$member->username?>/" title="<?=Language::GetText('member_rss')?>"><?=Language::GetText('member_rss')?></a>
        </p>
        <p><strong><?=Language::GetText('member_since')?>:</strong>&nbsp; <?=$member->date_created?></p>
        <p><strong><?=Language::GetText('profile_views')?>:</strong>&nbsp; <?=$member->views?></p>
        <p><strong><?=Language::GetText('subscribers')?>:</strong>&nbsp; <?php echo $sub_count[0]; ?></p>
        <p><strong><?=Language::GetText('website')?>:</strong>&nbsp; <?php echo ($member->website == '')?'':'<a href="' . $member->website . '" target="_blank" rel="nofollow">' . Functions::CutOff ($member->website, 30) . '</a>'; ?></p>
    </div>
    <p id="profile-description"><?=nl2br($member->about_me)?></p>

</div>




<!-- BEGIN Recent Videos -->
<?php if ($db->Count ($result_videos) >= 1): ?>
    <p class="large"><?=Language::GetText('recent_videos')?></p>

    <p class="post-header"><a href="<?=HOST?>/members/<?=$member->username?>/videos/" title="<?=Language::GetText('view_all_videos')?>"><?=Language::GetText('view_all_videos')?></a></p>
    <?php while ($row = $db->FetchObj ($result_videos)): ?>

        <?php
        $video = new Video ($row->video_id);
        $rating = Rating::GetRating ($row->video_id);
        ?>

        <div class="block">

            <a class="thumb" href="<?=HOST?>/videos/<?=$video->video_id?>/<?=$video->slug?>" title="<?=$video->title?>">
                <span class="duration"><?=$video->duration?></span>
                <span class="play-icon"></span>
                <img src="<?=$config->thumb_bucket_url?>/<?=$video->filename?>.jpg" alt="<?=$video->title?>" />
            </a>

            <a class="large" href="<?=HOST?>/videos/<?=$video->video_id?>/<?=$video->slug?>" title="<?=$video->title?>"><?=$video->title?></a>
            <p><?=Functions::CutOff ($video->description, 190)?></p>
            <span class="like">+<?=$rating->likes?></span>
            <span class="dislike">-<?=$rating->dislikes?></span>
            <br clear="all" />

        </div>

    <?php endwhile; ?>

<?php else: ?>
    <div class="block"><strong><?=Language::GetText('no_member_videos')?></strong></div>
<?php endif; ?>
<!-- END Recent Videos -->

<?php View::Footer(); ?>