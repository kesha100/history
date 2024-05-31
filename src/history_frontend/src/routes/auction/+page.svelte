<script>  
    import FormAuction from "../../components/FormAuction.svelte";
</script>

<main>
    <h1 class="md-2">Welcome to the Block Record Auction!</h1>
    <div class="text-center">
        <span>Anyone and anyone can submit your document to the site, along with a corresponding bid!  All you have to do is connect your wallet, submit your ICP, along with your document, and hope that your bid wins! This is a silent auction, so the winning bid will not be displayed.  However, the winning bid for yesterday will be displayed below.</span>
        <br/>
        <span>There will be no content moderation, we really mean it when we say that any information can be uploaded, because believe it or not all information has value, even wrong or false information!  We as a DAO have to be completely impartial as a repository of information to ensure that everyone's perspectives and viewpoints are recorded on the DAO in an unaltered fashion.  That’s the only way we’ll be a place of objective information as the years pass and our information base grows.</span>
        <br/>
    </div>
    <div>
        <FormAuction/>
    </div>
</main>

<style>
    main{
        color: aliceblue;
    }
</style>