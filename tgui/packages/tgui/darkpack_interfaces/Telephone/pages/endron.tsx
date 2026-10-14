// THIS IS A DARKPACK UI FILE
import { resolveAsset } from 'tgui/assets';

export const browser_endron = () => {
	const logoUrl = resolveAsset('endron_logo.webp');
	return `
<style>
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}

	body {
		background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
		min-height: 100vh;
	}

	h1, h2, h3, p, li, span, div, a {
		text-shadow: none !important;
	}

	.endron-container {
		font-family: Arial, sans-serif;
		line-height: 1.6;
		color: #333;
		background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
		min-height: 100vh;
		padding: 2em;
	}

	.endron-card {
		max-width: 800px;
		margin: 0 auto;
		background: white;
		border-radius: 8px;
		padding: 2em;
		box-shadow: 0 4px 6px rgba(0,0,0,0.1);
	}

	.endron-card h1 {
		color: #2c502e;
		margin-bottom: 0.5em;
		text-align: center;
	}

	.endron-accent {
		height: 3px;
		background: linear-gradient(90deg, #20af3f 0%, #085026 100%);
		margin-bottom: 2em;
	}

	.endron-card h2 {
		color: #385e34;
		margin-top: 1.5em;
		border-bottom: 2px solid #e0e0e0;
		padding-bottom: 0.5em;
	}

	.endron-card p {
		color: #555555;
		font-size: 1em;
	}

	.endron-card hr {
		margin: 2em 0;
		border: none;
		border-top: 1px solid #ddd;
	}

	.endron-footer {
		font-size: 0.85em;
		color: #999;
		text-align: center;
	}

	.endron-tagline {
		color: #11521c;
	}
</style>

<div class="endron-container">
	<div class="endron-card">
		<img src="${logoUrl}" style="max-width: 150px; margin: 1em auto; display: block;" />
        <div class="endron-accent"></div>
		<h2>关于我们</h2>
		<p>
			我们的星球广袤、壮丽而富饶。数千年来，人类享受着大地的馈赠，因为这里生机盎然，资源无穷无尽。
		</p>
		<p>
			安德隆致力于充分利用地球的资源，让这个世界成为你的世界。
            <br><br>
            长久以来，人类驯服自然与天地之力，得以自由驰骋。有了安德隆，梦想中的生活将成为现实。
		</p>
		<p>
			携手安德隆，我们能够创造繁荣昌盛的未来。齐心协力，让这颗星球成为我们的家园。
            <br><br>
            <strong class="endron-tagline">安德隆，为了更绿色的明天。</strong>
		</p>

		<hr />
		<p class="endron-footer">© 安德浏览器 v1.0.1</p>
	</div>
</div>
	`;
};

